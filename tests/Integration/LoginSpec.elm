module Integration.LoginSpec exposing (tests)

import Css.Helpers exposing (identifierToString)
import Expect exposing (equal)
import Login.Model exposing (Model, init, loggedInUser)
import Login.Msg exposing (Msg(..))
import Login.Ports exposing (checkRegistration, passwordReset, signIn)
import Login.Styles exposing (Classes(ResetPasswordButton))
import Login.Update as Update
import Login.View.Login as View
import Msg as Root exposing (Msg(MsgForLogin))
import Test exposing (..)
import Testable.Cmd
import Testable.Html
import Testable.Html.Selectors exposing (..)
import Testable.Html.Types exposing (Selector)
import Testable.TestContext exposing (..)


tests : Test
tests =
    describe "Login"
        [ describe "email check"
            [ test "shows loading button on submit" <|
                submitEmail
                    >> thenFind [ tag "button" ]
                    >> assertText (Expect.equal "Carregando...")
            , test "sends request via checkRegistration port" <|
                submitEmail
                    >> assertCalled (Cmd.map MsgForLogin <| checkRegistration "foo@bar.com")
            , test "shows beta message when user is not registered yet" <|
                submitEmail
                    >> update (MsgForLogin <| CheckRegistrationResponse False)
                    >> find []
                    >> assertText (expectToContainText "em fase beta")
            ]
        , describe "password check"
            [ test "shows loading button on submit" <|
                submitEmailThenPassword
                    >> thenFind [ tag "button" ]
                    >> assertText (Expect.equal "Carregando...")
            , test "sends request via checkRegistration port" <|
                submitEmailThenPassword
                    >> assertCalled (Cmd.map MsgForLogin <| signIn { email = "foo@bar.com", password = "baz" })
            , test "shows error when signing in and renable button" <|
                submitEmailThenPassword
                    >> update (MsgForLogin <| SignInResponse ( Just "Invalid password", Nothing ))
                    >> Expect.all
                        [ assertText (expectToContainText "Invalid password")
                        , find [ tag "button" ]
                            >> assertText (expectToContainText "Entrar")
                        ]
            , test "returns the logged in user from the model" <|
                submitEmailThenPassword
                    >> update (MsgForLogin <| SignInResponse ( Nothing, Just { id = "foo-bar-baz", name = "Baz" } ))
                    >> currentModel
                    >> (\result ->
                            case result of
                                Ok model ->
                                    Expect.equal (Just { id = "foo-bar-baz", name = "Baz" }) (loggedInUser model)

                                Err err ->
                                    Expect.fail (toString err)
                       )
            ]
        , describe "logout"
            [ test "removes the logged in user" <|
                loginContext
                    >> update (MsgForLogin <| SignInResponse ( Nothing, Just { id = "foo-bar-baz", name = "Baz" } ))
                    >> update (MsgForLogin SignOutResponse)
                    >> currentModel
                    >> (\result ->
                            case result of
                                Ok model ->
                                    Expect.equal Nothing (loggedInUser model)

                                Err err ->
                                    Expect.fail (toString err)
                       )
            ]
        , describe "password reset"
            [ test "shows loading on submit" <|
                submitEmailThenForgotPassword
                    >> find [ class ResetPasswordButton ]
                    >> assertText (Expect.equal "Carregando...")
            , test "calls the resetPassword port" <|
                submitEmailThenForgotPassword
                    >> assertCalled (Cmd.map MsgForLogin <| passwordReset "foo@bar.com")
            , test "shows error when reseting password and renable button" <|
                submitEmailThenForgotPassword
                    >> update (MsgForLogin <| PasswordResetResponse (Just "Could not send email"))
                    >> Expect.all
                        [ find []
                            >> assertText (expectToContainText "Could not send email")
                        , find [ class ResetPasswordButton ]
                            >> assertText (expectToContainText "Esqueci a Senha")
                        ]
            ]
        ]


class : Login.Styles.Classes -> Selector
class =
    Testable.Html.Selectors.class << identifierToString Login.Styles.namespace


loginContext : a -> TestContext Root.Msg Model
loginContext _ =
    startForTest
        { init = ( init Nothing, Testable.Cmd.none )
        , update = \msg model -> Tuple.mapSecond (Testable.Cmd.map MsgForLogin) <| Update.update msg model
        , view = View.login >> Testable.Html.map MsgForLogin
        }


submitEmail : a -> TestContext Root.Msg Model
submitEmail =
    loginContext
        >> find [ tag "input", attribute "type" "email" ]
        >> trigger "input" "{\"target\": {\"value\": \"foo@bar.com\"}}"
        >> find [ tag "form" ]
        >> trigger "submit" "{}"


submitEmailThenPassword : a -> TestContext Root.Msg Model
submitEmailThenPassword =
    submitEmail
        >> update (MsgForLogin <| CheckRegistrationResponse True)
        >> find [ tag "input", attribute "type" "password" ]
        >> trigger "input" "{\"target\": {\"value\": \"baz\"}}"
        >> find [ tag "form" ]
        >> trigger "submit" "{}"


submitEmailThenForgotPassword : a -> TestContext Root.Msg Model
submitEmailThenForgotPassword =
    submitEmail
        >> update (MsgForLogin <| CheckRegistrationResponse True)
        >> find [ class ResetPasswordButton ]
        >> trigger "click" "{}"


expectToContainText : String -> String -> Expect.Expectation
expectToContainText expected actual =
    Expect.true ("Expected\n\t" ++ actual ++ "\nto contain\n\t" ++ expected)
        (String.contains expected actual)
