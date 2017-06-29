module Msg exposing (Msg(..))

import GiveRide.Model as GiveRide
import Layout.Model as Layout
import Login.Model as Login
import Notifications.Model as Notifications
import Profile.Model as Profile
import Rides.Msg as Rides
import UrlRouter.Model as UrlRouter


type Msg
    = MsgForUrlRouter UrlRouter.Msg
    | MsgForLogin Login.Msg
    | MsgForRides Rides.Msg
    | MsgForLayout Layout.Msg
    | MsgForGiveRide GiveRide.Msg
    | MsgForNotifications Notifications.Msg
    | MsgForProfile Profile.Msg
