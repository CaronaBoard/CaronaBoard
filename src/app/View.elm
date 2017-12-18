module View exposing (staticView, view)

import Groups.View.Details
import Groups.View.List
import Groups.View.New
import Html
import Html.Styled exposing (Html, div, h1, text, toUnstyled)
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
import Rides.View.New
import RidesRequests.View.Details exposing (details)
import UrlRouter.Routes exposing (..)


view : Model -> Html Root.Msg
view model =
    case model.urlRouter.page of
        SplashScreenPage ->
            splashScreen

        LoginPage ->
            loginLayout (Html.Styled.map MsgForLogin <| login model.login)

        PasswordStepPage ->
            loginLayout (Html.Styled.map MsgForLogin <| passwordStep model.login)

        RegistrationPage ->
            loginLayout (Html.Styled.map MsgForLogin <| registrationStep model.login)

        RidesListPage groupId ->
            layout model (Rides.View.List.list groupId model)

        NotFoundPage ->
            h1 [] [ text "404 não encontrado" ]

        PasswordResetPage ->
            loginLayout passwordReset

        RidesCreatePage groupId ->
            layout model (Html.Styled.map MsgForRides <| Rides.View.New.new groupId model.rides)

        EnableNotificationsPage ->
            layout model (Html.Styled.map MsgForNotifications <| enableNotifications model.notifications)

        RideDetailsPage groupId rideId ->
            layout model (Rides.View.Details.details groupId rideId model)

        ProfilePage ->
            layout model (Html.Styled.map MsgForProfile <| profile model.profile)

        GroupsListPage ->
            layout model (Groups.View.List.list model.login model.groups)

        GroupsCreatePage ->
            layout model (Html.Styled.map MsgForGroups <| Groups.View.New.new model.groups)

        GroupDetailsPage groupId ->
            layout model (Groups.View.Details.details groupId model)

        RideRequestDetailsPage _ _ _ _ ->
            layout model (details model.ridesRequests)


staticView : Html.Html Root.Msg
staticView =
    toUnstyled <| splashScreen
