port module Ports exposing (subscriptions)

import GiveRide.Ports as GiveRide
import Groups.Ports as Groups
import Login.Ports as Login
import Model as Root exposing (Model, Msg(..))
import Notifications.Ports as Notifications
import Profile.Ports as Profile
import Rides.Ports as Rides


subscriptions : Model -> Sub Root.Msg
subscriptions model =
    Sub.batch
        [ Sub.map MsgForRides (Rides.subscriptions model.rides)
        , Sub.map MsgForLogin Login.subscriptions
        , Sub.map MsgForGiveRide GiveRide.subscriptions
        , Sub.map MsgForNotifications Notifications.subscriptions
        , Sub.map MsgForProfile Profile.subscriptions
        , Sub.map MsgForGroups Groups.subscriptions
        ]
