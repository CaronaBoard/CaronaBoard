module Update exposing (init, update)

import GiveRide.Update as GiveRide
import Groups.Update as Groups
import Infix exposing ((<*>))
import Layout.Update as Layout
import Login.Model exposing (signedInUser)
import Login.Update as Login
import Model exposing (Flags, Model, Msg(..))
import Navigation exposing (Location)
import Notifications.Update as Notifications
import Profile.Update as Profile
import Return exposing (Return, mapCmd, return, singleton)
import RideRequests.Update as RideRequests
import Rides.Update as Rides
import UrlRouter.Model
import UrlRouter.Update as UrlRouter


init : Flags -> Location -> Return Msg Model
init { currentUser, profile } location =
    let
        initialModel =
            { urlRouter = UrlRouter.init location
            , login = Login.init currentUser
            , rides = Rides.init
            , layout = Layout.init
            , giveRide = GiveRide.init
            , notifications = Notifications.init
            , profile = Profile.init profile
            , groups = Groups.init
            , rideRequests = ()
            }
    in
    initialRouting location initialModel


update : Msg -> Model -> Return Msg Model
update msg model =
    singleton Model
        <*> mapCmd MsgForUrlRouter (UrlRouter.update msg model)
        <*> mapCmd MsgForLogin (Login.update msg model.login)
        <*> mapCmd MsgForRides (Rides.update msg model.rides)
        <*> mapCmd MsgForLayout (Layout.update msg model.layout)
        <*> mapCmd MsgForGiveRide (GiveRide.update (signedInUser model.login) msg model.giveRide)
        <*> mapCmd MsgForNotifications (Notifications.update msg model.notifications)
        <*> mapCmd MsgForProfile (Profile.update msg model.profile)
        <*> mapCmd MsgForGroups (Groups.update msg model.groups)
        <*> mapCmd MsgForRideRequests (RideRequests.update msg ())


initialRouting : Location -> Model -> Return Msg Model
initialRouting location model =
    UrlRouter.update (MsgForUrlRouter <| UrlRouter.Model.UrlChange location) model
        |> Return.map (\urlRouter -> { model | urlRouter = urlRouter })
        |> mapCmd MsgForUrlRouter
