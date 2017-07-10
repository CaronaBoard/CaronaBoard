module Model exposing (Flags, Model, Msg(..))

import Groups.Model as Groups
import Layout.Model as Layout
import Login.Model as Login
import Notifications.Model as Notifications
import Profile.Model as Profile exposing (Profile)
import Rides.Model as Rides
import RidesRequests.Model as RidesRequests
import UrlRouter.Model as UrlRouter exposing (Msg(UrlChange))


type alias Model =
    { urlRouter : UrlRouter.Model
    , login : Login.Model
    , rides : Rides.Collection
    , layout : Layout.Model
    , notifications : Notifications.Model
    , profile : Profile.Model
    , groups : Groups.Model
    , ridesRequests : RidesRequests.Collection
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
    | MsgForNotifications Notifications.Msg
    | MsgForProfile Profile.Msg
    | MsgForGroups Groups.Msg
    | MsgForRidesRequests RidesRequests.Msg
