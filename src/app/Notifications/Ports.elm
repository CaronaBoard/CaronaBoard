port module Notifications.Ports exposing (enableNotifications, subscriptions)

import Common.Response exposing (FirebaseResponse, fromFirebase)
import Notifications.Model exposing (Msg(..))


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ notificationsResponse (fromFirebase >> NotificationsResponse)
        ]


port enableNotifications : () -> Cmd msg


port notificationsResponse : (FirebaseResponse Bool -> msg) -> Sub msg
