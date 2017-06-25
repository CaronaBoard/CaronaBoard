module Integration.NotificationsSpec exposing (tests)

import Expect exposing (equal)
import Helpers exposing (expectToContainText, initialContext, someUser, toLocation)
import Model exposing (Model)
import Msg as Root exposing (Msg(..))
import Notifications.Msg exposing (..)
import Notifications.Ports
import Test exposing (..)
import Testable.Html.Selectors exposing (..)
import Testable.TestContext exposing (..)
import UrlRouter.Routes exposing (Page(..), toPath)


tests : Test
tests =
    describe "enable notifications" <|
        [ test "shows loading on submit" <|
            enableNotifications
                >> find [ id "enableNotifications" ]
                >> assertText (Expect.equal "Carregando...")
        , test "sends request to enable notifications via port" <|
            enableNotifications
                >> assertCalled (Cmd.map MsgForNotifications <| Notifications.Ports.enableNotifications ())
        , test "shows error when user does not allow notifications" <|
            enableNotifications
                >> update (MsgForNotifications <| NotificationsResponse ( Just "I don't like notifications", Nothing ))
                >> find []
                >> assertText (expectToContainText "As notificações não foram ativadas")
        , test "shows success message when notifications are enabled" <|
            enableNotifications
                >> update (MsgForNotifications <| NotificationsResponse ( Nothing, Just True ))
                >> find []
                >> assertText (expectToContainText "Notificações ativadas")
        ]


enableNotifications : a -> TestContext Root.Msg Model
enableNotifications =
    initialContext someUser EnableNotificationsPage
        >> find [ tag "form" ]
        >> trigger "submit" "{}"
