module Update exposing (init, update)

import GiveRide.Update as GiveRide
import Infix exposing ((<*>))
import Layout.Update as Layout
import Login.Model exposing (signedInUser)
import Login.Update as Login
import Model exposing (Flags, Model, Msg(..))
import Navigation exposing (Location)
import Notifications.Update as Notifications
import Profile.Update as Profile
import Return exposing (Return, mapCmd, return, singleton)
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
            }
    in
    updateUrlRouter location initialModel


update : Msg -> Model -> Return Msg Model
update msg model =
    let
        urlRouter =
            mapCmd MsgForUrlRouter (UrlRouter.update model.notifications model.profile model.login msg model.urlRouter)

        login =
            mapCmd MsgForLogin (Login.update msg model.login)

        rides =
            mapCmd MsgForRides (Rides.update msg model.rides)

        layout =
            mapCmd MsgForLayout (Layout.update msg model.layout)

        giveRide =
            mapCmd MsgForGiveRide (GiveRide.update (signedInUser model.login) msg model.giveRide)

        notifications =
            mapCmd MsgForNotifications (Notifications.update msg model.notifications)

        profile =
            mapCmd MsgForProfile (Profile.update msg model.profile)
    in
    singleton Model
        <*> urlRouter
        <*> login
        <*> rides
        <*> layout
        <*> giveRide
        <*> notifications
        <*> profile


updateUrlRouter : Location -> Model -> Return Msg Model
updateUrlRouter location model =
    let
        updatedUrlRouter =
            UrlRouter.update model.notifications model.profile model.login (MsgForUrlRouter <| UrlRouter.Model.UrlChange location) model.urlRouter
    in
    ( { model | urlRouter = Tuple.first updatedUrlRouter }
    , Cmd.map MsgForUrlRouter <| Tuple.second updatedUrlRouter
    )
