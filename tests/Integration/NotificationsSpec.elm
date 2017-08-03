module Integration.NotificationsSpec exposing (tests)

import Common.Response exposing (Response(..))
import Helpers exposing (initialContext, signedInContext, someUser, toLocation)
import Model as Root exposing (Model, Msg(..))
import Notifications.Model exposing (..)
import Notifications.Ports
import Test exposing (..)
import Test.Html.Event exposing (submit)
import Test.Html.Query exposing (..)
import Test.Html.Selector exposing (..)
import TestContext exposing (..)
import Time exposing (Time)
import UrlRouter.Routes exposing (Page(..), toPath)


tests : Test
tests =
    describe "enable notifications" <|
        [ test "shows loading on submit" <|
            enableNotifications
                >> expectView
                >> find [ id "enableNotifications" ]
                >> has [ text "Carregando..." ]
        , test "sends request to enable notifications via port" <|
            enableNotifications
                >> expectCmd (Cmd.map MsgForNotifications <| Notifications.Ports.enableNotifications ())
        , test "shows error when user does not allow notifications" <|
            enableNotifications
                >> update (MsgForNotifications <| NotificationsResponse (Error "I don't like notifications"))
                >> expectView
                >> has [ text "As notificações não foram ativadas" ]
        , test "shows success message when notifications are enabled" <|
            enableNotifications
                >> update (MsgForNotifications <| NotificationsResponse (Success True))
                >> expectView
                >> has [ text "Notificações ativadas" ]
        , describe "notices"
            [ test "shows notice" <|
                signedInContext GroupsListPage
                    >> update (MsgForNotifications <| ShowNotice "banana!")
                    >> expectView
                    >> has [ text "banana!" ]
            , test "hides notice after 3 seconds" <|
                signedInContext GroupsListPage
                    >> update (MsgForNotifications <| ShowNotice "banana!")
                    >> advanceTime (3 * Time.second)
                    >> expectView
                    >> hasNot [ text "banana!" ]
            ]
        ]


enableNotifications : a -> TestContext Root.Model Root.Msg
enableNotifications =
    signedInContext EnableNotificationsPage
        >> simulate (find [ tag "form" ]) submit
