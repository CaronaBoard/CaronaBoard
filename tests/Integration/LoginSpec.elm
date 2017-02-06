module Integration.LoginSpec exposing (..)

import Test exposing (..)
import Testable.TestContext exposing (..)
import Testable.Html.Selectors exposing (..)
import Expect exposing (equal)
import Login.Update as Update
import Login.Model as Model exposing (Model, loggedInUser)
import Login.View.Login as View
import Login.Msg exposing (Msg(..))
import Login.Ports exposing (checkRegistration)
import Login.Msg
import Testable.Cmd


loginContext : a -> TestContext Msg Model
loginContext _ =
    startForTest
        { init = ( Model.init Nothing, Testable.Cmd.none )
        , update = (\msg model -> ( Update.update msg model, Update.cmdUpdate msg model ))
        , view = View.login
        }


submitEmail : a -> TestContext Msg Model
submitEmail =
    loginContext
        >> find [ tag "input", attribute "type" "email" ]
        >> trigger "input" "{\"target\": {\"value\": \"foo@bar.com\"}}"
        >> find [ tag "form" ]
        >> trigger "submit" "{}"


submitEmailThenPassword : a -> TestContext Msg Model
submitEmailThenPassword =
    submitEmail
        >> update (Login.Msg.CheckRegistrationResponse True)
        >> find [ tag "input", attribute "type" "password" ]
        >> trigger "input" "{\"target\": {\"value\": \"baz\"}}"
        >> find [ tag "form" ]
        >> trigger "submit" "{}"


expectToContainText : String -> String -> Expect.Expectation
expectToContainText expected actual =
    Expect.true ("Expected\n\t" ++ actual ++ "\nto contain\n\t" ++ expected)
        (String.contains expected actual)


tests : Test
tests =
    describe "Login"
        [ test "renders the login when user is not logged in yet" <|
            loginContext
                >> find [ id "login" ]
                >> assertPresent
        , describe "email check"
            [ test "shows loading button on submit" <|
                submitEmail
                    >> thenFind [ tag "input", attribute "type" "submit" ]
                    >> assertAttribute "value" (Expect.equal "Carregando...")
            , test "calls checkRegistration port" <|
                submitEmail
                    >> assertCalled (checkRegistration "foo@bar.com")
            , test "shows beta message when user is not registered yet" <|
                submitEmail
                    >> update (CheckRegistrationResponse False)
                    >> find [ id "login" ]
                    >> assertText (expectToContainText "em fase de testes")
            ]
        , describe "password check"
            [ test "shows loading button on submit" <|
                submitEmailThenPassword
                    >> thenFind [ tag "input", attribute "type" "submit" ]
                    >> assertAttribute "value" (Expect.equal "Carregando...")
            , test "shows error when signing in and renable button" <|
                submitEmailThenPassword
                    >> update (SignInResponse ( Just "Invalid password", Nothing ))
                    >> Expect.all
                        [ find [ id "login" ]
                            >> assertText (expectToContainText "Invalid password")
                        , find [ tag "input", attribute "type" "submit" ]
                            >> assertAttribute "value" (Expect.equal "Entrar")
                        ]
            , test "returns the logged in user from the model" <|
                submitEmailThenPassword
                    >> update (SignInResponse ( Nothing, Just { id = "foo-bar-baz", name = "Baz" } ))
                    >> currentModel
                    >> (\result ->
                            case result of
                                Ok model ->
                                    Expect.equal (Just { id = "foo-bar-baz", name = "Baz" }) (loggedInUser model)

                                Err err ->
                                    Expect.fail (toString err)
                       )
            ]
        ]
