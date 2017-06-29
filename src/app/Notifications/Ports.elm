port module Notifications.Ports exposing (enableNotifications, subscriptions)

import Common.Response exposing (FirebaseResponse)
import Notifications.Model exposing (Msg(..))


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ notificationsResponse NotificationsResponse
        ]


port enableNotifications : () -> Cmd msg


port notificationsResponse : (FirebaseResponse Bool -> msg) -> Sub msg
