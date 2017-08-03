module Integration.LoginSpec exposing (tests)

import Common.Response exposing (Response(..))
import Css.Helpers exposing (identifierToString)
import Expect exposing (equal)
import Helpers exposing (expectCurrentPage, fixtures, initialContext, successSignIn, successSignInWithoutProfile)
import Login.Model exposing (Model, Msg(..), signedInUser)
import Login.Ports exposing (..)
import Login.Styles exposing (Classes(..))
import Model as Root exposing (Msg(MsgForLogin))
import Test exposing (..)
import Test.Html.Event exposing (click, input, submit)
import Test.Html.Query exposing (..)
import Test.Html.Selector exposing (..)
import TestContext exposing (..)
import UrlRouter.Routes exposing (Page(..))


tests : Test
tests =
    describe "Login"
        [ describe "email check"
            [ test "shows loading button on submit" <|
                submitEmail
                    >> expectView
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
                            Expect.equal (Just fixtures.user) (signedInUser model.login)
                        )
            , test "goes to groups page after sign in" <|
                submitEmailThenPassword
                    >> successSignIn
                    >> expectCurrentPage GroupsListPage
            ]
        , describe "logout"
            [ test "removes the signed in user" <|
                loginContext
                    >> successSignIn
                    >> update (MsgForLogin (SignOutResponse (Success True)))
                    >> expectModel
                        (\model ->
                            Expect.equal Nothing (signedInUser model.login)
                        )
            ]
        , describe "password reset"
            [ test "shows loading on submit" <|
                submitEmailThenForgotPassword
                    >> expectView
                    >> find [ id "resetPassword" ]
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
                        , find [ id "resetPassword" ]
                            >> has [ text "Esqueci a Senha" ]
                        ]
            ]
        , describe "registration"
            [ test "shows loading on submit" <|
                submitEmailThenRegistration
                    >> expectView
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
            , test "goes to profile page after registration" <|
                submitEmailThenRegistration
                    >> successSignInWithoutProfile
                    >> expectCurrentPage ProfilePage
            ]
        ]


class : Login.Styles.Classes -> Selector
class =
    Test.Html.Selector.class << identifierToString Login.Styles.namespace


loginContext : a -> TestContext Root.Model Root.Msg
loginContext =
    initialContext Nothing Nothing LoginPage


submitEmail : a -> TestContext Root.Model Root.Msg
submitEmail =
    loginContext
        >> simulate (find [ tag "input", attribute "type" "email" ]) (input "foo@bar.com")
        >> simulate (find [ tag "form" ]) submit


submitEmailThenPassword : a -> TestContext Root.Model Root.Msg
submitEmailThenPassword =
    submitEmail
        >> update (MsgForLogin <| CheckRegistrationResponse (Success True))
        >> simulate (find [ tag "input", attribute "type" "password" ]) (input "baz")
        >> simulate (find [ tag "form" ]) submit


submitEmailThenForgotPassword : a -> TestContext Root.Model Root.Msg
submitEmailThenForgotPassword =
    submitEmail
        >> update (MsgForLogin <| CheckRegistrationResponse (Success True))
        >> simulate (find [ id "resetPassword" ]) click


submitEmailThenRegistration : a -> TestContext Root.Model Root.Msg
submitEmailThenRegistration =
    submitEmail
        >> update (MsgForLogin <| CheckRegistrationResponse (Success False))
        >> simulate (find [ id "password" ]) (input "baz")
        >> simulate (find [ tag "form" ]) submit
