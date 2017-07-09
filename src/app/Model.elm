module Model exposing (Flags, Model, Msg(..))

import GiveRide.Model as GiveRide
import Groups.Model as Groups
import Layout.Model as Layout
import Login.Model as Login
import Notifications.Model as Notifications
import Profile.Model as Profile exposing (Profile)
import RidesRequests.Model as RidesRequests
import Rides.Model as Rides
import UrlRouter.Model as UrlRouter exposing (Msg(UrlChange))


type alias Model =
    { urlRouter : UrlRouter.Model
    , login : Login.Model
    , rides : Rides.Model
    , layout : Layout.Model
    , giveRide : GiveRide.Model
    , notifications : Notifications.Model
    , profile : Profile.Model
    , groups : Groups.Model
    , ridesRequests : RidesRequests.Model
    }


type alias Flags =
    { currentUser : Maybe Login.User
    , profile : Maybe Profile
    }


type Msg
    = MsgForUrlRouter UrlRouter.Msg
    | MsgForLogin Login.Msg
    | MsgForRides Rides.Msg
    | MsgForLayout Layout.Msg
    | MsgForGiveRide GiveRide.Msg
    | MsgForNotifications Notifications.Msg
    | MsgForProfile Profile.Msg
    | MsgForGroups Groups.Msg
    | MsgForRidesRequests RidesRequests.Msg
