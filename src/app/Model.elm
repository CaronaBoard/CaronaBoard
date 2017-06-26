module Model exposing (Flags, Model, init)

import GiveRide.Model as GiveRide
import Layout.Model as Layout
import Login.Model as Login
import Msg exposing (Msg(MsgForUrlRouter))
import Navigation exposing (Location)
import Notifications.Model as Notifications
import Profile.Model as Profile
import RideRequest.Model as RideRequest
import Rides.Model as Rides
import Testable.Cmd
import UrlRouter.Model as UrlRouter
import UrlRouter.Msg exposing (Msg(UrlChange))
import UrlRouter.Update as UrlRouterUpdate


type alias Model =
    { urlRouter : UrlRouter.Model
    , login : Login.Model
    , rides : Rides.Model
    , layout : Layout.Model
    , giveRide : GiveRide.Model
    , notifications : Notifications.Model
    , rideRequest : RideRequest.Model
    , profile : Profile.Model
    }


type alias Flags =
    { currentUser : Maybe Login.User
    }


init : Flags -> Location -> ( Model, Testable.Cmd.Cmd Msg.Msg )
init { currentUser } location =
    let
        initialModel =
            { urlRouter = UrlRouter.init location
            , login = Login.init currentUser
            , rides = Rides.init
            , layout = Layout.init
            , giveRide = GiveRide.init
            , notifications = Notifications.init
            , rideRequest = RideRequest.init
            , profile = Profile.init
            }
    in
    updateUrlRouter location initialModel


updateUrlRouter : Location -> Model -> ( Model, Testable.Cmd.Cmd Msg.Msg )
updateUrlRouter location model =
    let
        updatedUrlRouter =
            UrlRouterUpdate.update model.notifications model.login (MsgForUrlRouter <| UrlChange location) model.urlRouter
    in
    ( { model | urlRouter = Tuple.first updatedUrlRouter }
    , Testable.Cmd.map MsgForUrlRouter <| Tuple.second updatedUrlRouter
    )
