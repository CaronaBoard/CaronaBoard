module View exposing (staticView, view)

import GiveRide.View exposing (giveRide)
import Groups.View exposing (groupsList)
import Html exposing (div, h1, text)
import Layout.View.Layout exposing (layout)
import Layout.View.SplashScreen exposing (splashScreen)
import Login.View.Layout exposing (loginLayout)
import Login.View.Login exposing (login)
import Login.View.PasswordReset exposing (passwordReset)
import Model as Root exposing (Model, Msg(..))
import Notifications.View.EnableNotifications exposing (enableNotifications)
import Profile.View exposing (profile)
import Rides.Ride.View exposing (ride)
import Rides.View.Instructions exposing (instructions)
import Rides.View.RidesList exposing (ridesList)
import UrlRouter.Routes exposing (..)


view : Model -> Html.Html Root.Msg
view model =
    case model.urlRouter.page of
        SplashScreenPage ->
            splashScreen

        LoginPage ->
            loginLayout (Html.map MsgForLogin <| login model.login)

        RidesPage groupId ->
            layout model
                (div []
                    [ instructions
                    , ridesList groupId model.rides
                    ]
                )

        NotFoundPage ->
            h1 [] [ text "404 não encontrado" ]

        PasswordResetPage ->
            loginLayout passwordReset

        GiveRidePage groupId ->
            layout model (Html.map MsgForGiveRide <| giveRide groupId model.giveRide)

        EnableNotificationsPage ->
            layout model (Html.map MsgForNotifications <| enableNotifications model.notifications)

        RidePage groupId rideId ->
            layout model (Html.map MsgForRides <| ride rideId model)

        ProfilePage ->
            layout model (Html.map MsgForProfile <| profile model.profile)

        GroupsPage ->
            layout model (groupsList model.groups)


staticView : Html.Html Root.Msg
staticView =
    splashScreen
