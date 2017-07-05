module Integration.LoginSpec exposing (tests)

import Common.Response exposing (Response(..))
import Css.Helpers exposing (identifierToString)
import Expect exposing (equal)
import Helpers exposing (fixtures, successSignIn)
import Html
import Login.Model exposing (Model, Msg(..), signedInUser)
import Login.Ports exposing (..)
import Login.Styles exposing (Classes(..))
import Login.Update as Update exposing (init)
import Login.View.Login as View
import Model as Root exposing (Msg(MsgForLogin))
import Test exposing (..)
import Test.Html.Event exposing (click, input, submit)
import Test.Html.Query exposing (..)
import Test.Html.Selector exposing (..)
import TestContext exposing (..)


tests : Test
tests =
    describe "Login"
        [ describe "email check"
            [ test "shows loading button on submit" <|
                submitEmail
                    >> expectView
                    >> find [ class SubmitButton ]
                    >> has [ text "Carregando..." ]
            , test "sends request via checkRegistration port" <|
                submitEmail
                    >> expectCmd (Cmd.map MsgForLogin <| checkRegistration "foo@bar.com")
            , test "goes to registration if not registered yet" <|
                submitEmail
                    >> update (MsgForLogin <| CheckRegistrationResponse (Success False))
                    >> expectView
                    >> find []
                    >> has [ text "Cadastro" ]
            ]
        , describe "password check"
            [ test "shows loading button on submit" <|
                submitEmailThenPassword
                    >> expectView
                    >> find [ class SubmitButton ]
                    >> has [ text "Carregando..." ]
            , test "sends request via checkRegistration port" <|
                submitEmailThenPassword
                    >> expectCmd (Cmd.map MsgForLogin <| signIn { email = "foo@bar.com", password = "baz" })
            , test "shows error when signing in and renable button" <|
                submitEmailThenPassword
                    >> update (MsgForLogin <| SignInResponse (Error "Invalid password"))
                    >> expectView
                    >> Expect.all
                        [ has [ text "Invalid password" ]
                        , find [ class SubmitButton ]
                            >> has [ text "Entrar" ]
                        ]
            , test "returns the signed in user from the model" <|
                submitEmailThenPassword
                    >> successSignIn
                    >> expectModel
                        (\model ->
                            Expect.equal (Just fixtures.user) (signedInUser model)
                        )
            ]
        , describe "logout"
            [ test "removes the signed in user" <|
                loginContext
                    >> successSignIn
                    >> update (MsgForLogin (SignOutResponse (Success True)))
                    >> expectModel
                        (\model ->
                            Expect.equal Nothing (signedInUser model)
                        )
            ]
        , describe "password reset"
            [ test "shows loading on submit" <|
                submitEmailThenForgotPassword
                    >> expectView
                    >> find [ class ResetPasswordButton ]
                    >> has [ text "Carregando..." ]
            , test "calls the resetPassword port" <|
                submitEmailThenForgotPassword
                    >> expectCmd (Cmd.map MsgForLogin <| passwordReset "foo@bar.com")
            , test "shows error when reseting password and renable button" <|
                submitEmailThenForgotPassword
                    >> update (MsgForLogin <| PasswordResetResponse (Error "Could not send email"))
                    >> expectView
                    >> Expect.all
                        [ has [ text "Could not send email" ]
                        , find [ class ResetPasswordButton ]
                            >> has [ text "Esqueci a Senha" ]
                        ]
            ]
        , describe "registration"
            [ test "shows loading on submit" <|
                submitEmailThenRegistration
                    >> expectView
                    >> find [ class SubmitButton ]
                    >> has [ text "Carregando..." ]
            , test "sends request via signUp port" <|
                submitEmailThenRegistration
                    >> expectCmd (Cmd.map MsgForLogin <| signUp { email = "foo@bar.com", password = "baz" })
            , test "shows error when signUp port returns an error" <|
                submitEmailThenRegistration
                    >> update (MsgForLogin <| SignUpResponse (Error "undefined is not a function"))
                    >> expectView
                    >> find []
                    >> has [ text "not a function" ]
            ]
        ]


class : Login.Styles.Classes -> Selector
class =
    Test.Html.Selector.class << identifierToString Login.Styles.namespace


loginContext : a -> TestContext Model Root.Msg
loginContext _ =
    Html.program
        { init = ( init Nothing, Cmd.none )
        , update = \msg model -> Tuple.mapSecond (Cmd.map MsgForLogin) <| Update.update msg model
        , view = View.login >> Html.map MsgForLogin
        , subscriptions = always Sub.none
        }
        |> start


submitEmail : a -> TestContext Model Root.Msg
submitEmail =
    loginContext
        >> simulate (find [ tag "input", attribute "type" "email" ]) (input "foo@bar.com")
        >> simulate (find [ tag "form" ]) submit


submitEmailThenPassword : a -> TestContext Model Root.Msg
submitEmailThenPassword =
    submitEmail
        >> update (MsgForLogin <| CheckRegistrationResponse (Success True))
        >> simulate (find [ tag "input", attribute "type" "password" ]) (input "baz")
        >> simulate (find [ tag "form" ]) submit


submitEmailThenForgotPassword : a -> TestContext Model Root.Msg
submitEmailThenForgotPassword =
    submitEmail
        >> update (MsgForLogin <| CheckRegistrationResponse (Success True))
        >> simulate (find [ class ResetPasswordButton ]) click


submitEmailThenRegistration : a -> TestContext Model Root.Msg
submitEmailThenRegistration =
    submitEmail
        >> update (MsgForLogin <| CheckRegistrationResponse (Success False))
        >> simulate (find [ id "password" ]) (input "baz")
        >> simulate (find [ tag "form" ]) submit
