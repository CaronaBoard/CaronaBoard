module Model exposing (Flags, Model, Msg(..))

import GiveRide.Model as GiveRide
import Layout.Model as Layout
import Login.Model as Login
import Notifications.Model as Notifications
import Profile.Model as Profile exposing (Profile)
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
