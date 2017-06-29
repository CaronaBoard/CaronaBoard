module Integration.LoginSpec exposing (tests)

import Common.Response exposing (Response(..))
import Css.Helpers exposing (identifierToString)
import Expect exposing (equal)
import Helpers exposing (expectToContainText, fixtures, successSignIn)
import Login.Model exposing (Model, Msg(..), loggedInUser)
import Login.Ports exposing (..)
import Login.Styles exposing (Classes(..))
import Login.Update as Update exposing (init)
import Login.View.Login as View
import Model as Root exposing (Msg(MsgForLogin))
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
            , test "goes to registration if not registered yet" <|
                submitEmail
                    >> update (MsgForLogin <| CheckRegistrationResponse (Success False))
                    >> find []
                    >> assertText (expectToContainText "Cadastro")
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
                    >> update (MsgForLogin <| SignInResponse (Error "Invalid password"))
                    >> Expect.all
                        [ assertText (expectToContainText "Invalid password")
                        , find [ tag "button" ]
                            >> assertText (expectToContainText "Entrar")
                        ]
            , test "returns the logged in user from the model" <|
                submitEmailThenPassword
                    >> successSignIn
                    >> currentModel
                    >> (\result ->
                            case result of
                                Ok model ->
                                    Expect.equal (Just fixtures.user) (loggedInUser model)

                                Err err ->
                                    Expect.fail (toString err)
                       )
            ]
        , describe "logout"
            [ test "removes the logged in user" <|
                loginContext
                    >> successSignIn
                    >> update (MsgForLogin (SignOutResponse (Success True)))
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
                    >> update (MsgForLogin <| PasswordResetResponse (Error "Could not send email"))
                    >> Expect.all
                        [ find []
                            >> assertText (expectToContainText "Could not send email")
                        , find [ class ResetPasswordButton ]
                            >> assertText (expectToContainText "Esqueci a Senha")
                        ]
            ]
        , describe "registration"
            [ test "shows loading on submit" <|
                submitEmailThenRegistration
                    >> find [ class SubmitButton ]
                    >> assertText (Expect.equal "Carregando...")
            , test "sends request via signUp port" <|
                submitEmailThenRegistration
                    >> assertCalled (Cmd.map MsgForLogin <| signUp { email = "foo@bar.com", password = "baz" })
            , test "shows error when signUp port returns an error" <|
                submitEmailThenRegistration
                    >> update (MsgForLogin <| SignUpResponse (Error "undefined is not a function"))
                    >> find []
                    >> assertText (expectToContainText "not a function")
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
        >> update (MsgForLogin <| CheckRegistrationResponse (Success True))
        >> find [ tag "input", attribute "type" "password" ]
        >> trigger "input" "{\"target\": {\"value\": \"baz\"}}"
        >> find [ tag "form" ]
        >> trigger "submit" "{}"


submitEmailThenForgotPassword : a -> TestContext Root.Msg Model
submitEmailThenForgotPassword =
    submitEmail
        >> update (MsgForLogin <| CheckRegistrationResponse (Success True))
        >> find [ class ResetPasswordButton ]
        >> trigger "click" "{}"


submitEmailThenRegistration : a -> TestContext Root.Msg Model
submitEmailThenRegistration =
    submitEmail
        >> update (MsgForLogin <| CheckRegistrationResponse (Success False))
        >> find [ id "password" ]
        >> trigger "input" "{\"target\": {\"value\": \"baz\"}}"
        >> find [ tag "form" ]
        >> trigger "submit" "{}"
