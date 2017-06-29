module View exposing (staticView, view)

import GiveRide.View exposing (giveRide)
import Html
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
import Testable
import Testable.Html exposing (div, h1, text)
import UrlRouter.Routes exposing (..)


view : Model -> Testable.Html.Html Root.Msg
view model =
    case model.urlRouter.page of
        SplashScreenPage ->
            splashScreen

        LoginPage ->
            loginLayout (Testable.Html.map MsgForLogin <| login model.login)

        RidesPage ->
            layout model
                (div []
                    [ instructions
                    , ridesList model.rides
                    ]
                )

        NotFoundPage ->
            h1 [] [ text "404 não encontrado" ]

        PasswordResetPage ->
            loginLayout passwordReset

        GiveRidePage ->
            layout model (Testable.Html.map MsgForGiveRide <| giveRide model.giveRide)

        EnableNotificationsPage ->
            layout model (Testable.Html.map MsgForNotifications <| enableNotifications model.notifications)

        RidePage rideId ->
            layout model (Testable.Html.map MsgForRides <| ride rideId model)

        ProfilePage ->
            layout model (Testable.Html.map MsgForProfile <| profile model.profile)


staticView : Html.Html Root.Msg
staticView =
    Testable.view (always splashScreen) Nothing
