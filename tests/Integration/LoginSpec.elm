module Integration.LoginSpec exposing (..)

import Test exposing (..)
import Testable.TestContext exposing (..)
import Testable.Html.Selectors exposing (..)
import Expect exposing (equal)
import Update
import Model
import View
import Msg
import Login.Ports exposing (checkRegistration)
import Login.Msg


loginContext : a -> TestContext Msg.Msg Model.Model
loginContext _ =
    { init = Model.init
    , update = Update.update
    , view = View.view
    }
        |> startForTest


submitEmail : a -> TestContext Msg.Msg Model.Model
submitEmail =
    loginContext
        >> find [ tag "input", attribute "type" "email" ]
        >> trigger "input" "{\"target\": {\"value\": \"foo@bar.com\"}}"
        >> find [ tag "form" ]
        >> trigger "submit" "{}"


expectToContainText : String -> String -> Expect.Expectation
expectToContainText expected actual =
    Expect.true ("Expected\n\t" ++ actual ++ "\nto contain\n\t" ++ expected)
        (String.contains expected actual)


tests : Test
tests =
    describe "Login"
        [ test "renders the login when user is not logged in yet"
            <| loginContext
            >> find [ id "login" ]
            >> assertPresent
        , describe "email check"
            [ test "shows loading button on submit"
                <| submitEmail
                >> thenFind [ tag "input", attribute "type" "submit" ]
                >> assertAttribute "value" (Expect.equal "Carregando...")
            , test "calls checkRegistration port"
                <| submitEmail
                >> assertCalled (Cmd.map Msg.MsgForLogin <| checkRegistration "foo@bar.com")
            , test "shows beta message when user is not registered yet"
                <| submitEmail
                >> update (Msg.MsgForLogin <| Login.Msg.CheckRegistrationResponse False)
                >> find [ id "login" ]
                >> assertText (expectToContainText "em fase de testes")
            ]
        ]
