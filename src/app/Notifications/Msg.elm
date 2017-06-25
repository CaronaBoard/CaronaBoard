module Notifications.Msg exposing (Msg(..))

import Common.Response exposing (FirebaseResponse)


type Msg
    = EnableNotifications
    | NotificationsResponse (FirebaseResponse Bool)
