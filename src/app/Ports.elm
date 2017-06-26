port module Ports exposing (subscriptions)

import GiveRide.Ports as GiveRide
import Login.Ports as Login
import Model exposing (Model)
import Msg as Root exposing (Msg(..))
import Notifications.Ports as Notifications
import Profile.Ports as Profile
import RideRequest.Ports as RideRequest
import Rides.Ports as Rides


subscriptions : Model -> Sub Root.Msg
subscriptions _ =
    Sub.batch
        [ Sub.map MsgForRides Rides.subscriptions
        , Sub.map MsgForLogin Login.subscriptions
        , Sub.map MsgForGiveRide GiveRide.subscriptions
        , Sub.map MsgForNotifications Notifications.subscriptions
        , Sub.map MsgForRideRequest RideRequest.subscriptions
        , Sub.map MsgForProfile Profile.subscriptions
        ]
