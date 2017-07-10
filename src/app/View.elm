module View exposing (staticView, view)

import GiveRide.View.New
import Groups.View.List
import Html exposing (div, h1, text)
import Layout.View.Layout exposing (layout)
import Layout.View.SplashScreen exposing (splashScreen)
import Login.View.Layout exposing (loginLayout)
import Login.View.Login exposing (login)
import Login.View.PasswordReset exposing (passwordReset)
import Login.View.PasswordStep exposing (passwordStep)
import Login.View.Registration exposing (registrationStep)
import Model as Root exposing (Model, Msg(..))
import Notifications.View.EnableNotifications exposing (enableNotifications)
import Profile.View exposing (profile)
import Rides.View.Details
import Rides.View.List
import RidesRequests.View.Details exposing (details)
import UrlRouter.Routes exposing (..)


view : Model -> Html.Html Root.Msg
view model =
    case model.urlRouter.page of
        SplashScreenPage ->
            splashScreen

        LoginPage ->
            loginLayout (Html.map MsgForLogin <| login model.login)

        PasswordStepPage ->
            loginLayout (Html.map MsgForLogin <| passwordStep model.login)

        RegistrationPage ->
            loginLayout (Html.map MsgForLogin <| registrationStep model.login)

        RidesPage groupId ->
            layout model (Rides.View.List.list groupId model)

        NotFoundPage ->
            h1 [] [ text "404 não encontrado" ]

        PasswordResetPage ->
            loginLayout passwordReset

        GiveRidePage groupId ->
            layout model (Html.map MsgForGiveRide <| GiveRide.View.New.new groupId model.giveRide)

        EnableNotificationsPage ->
            layout model (Html.map MsgForNotifications <| enableNotifications model.notifications)

        RidePage groupId rideId ->
            layout model (Rides.View.Details.details groupId rideId model)

        ProfilePage ->
            layout model (Html.map MsgForProfile <| profile model.profile)

        GroupsPage ->
            layout model (Groups.View.List.list model.groups)

        RideRequestPage _ _ _ _ ->
            layout model (details model.ridesRequests)


staticView : Html.Html Root.Msg
staticView =
    splashScreen
