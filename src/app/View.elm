module View exposing (staticView, view)

import GiveRide.View exposing (giveRide)
import Html
import Layout.View.Header exposing (header)
import Layout.View.SplashScreen exposing (splashScreen)
import Login.View.Layout exposing (loginLayout)
import Login.View.Login exposing (login)
import Login.View.PasswordReset exposing (passwordReset)
import Model exposing (Model, init)
import Msg as Root exposing (Msg(..))
import Rides.Styles exposing (Classes(Page), class)
import Rides.View.Instructions exposing (instructions)
import Rides.View.RoutesList exposing (routesList)
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
            div [ class Page ]
                [ header model.layout
                , instructions
                , routesList model.rides
                ]

        NotFoundPage ->
            h1 [] [ text "404 não encontrado" ]

        PasswordResetPage ->
            loginLayout passwordReset

        GiveRidePage ->
            div [ class Page ]
                [ header model.layout
                , Testable.Html.map MsgForGiveRide <| giveRide model.giveRide
                ]


staticView : Html.Html Root.Msg
staticView =
    Testable.view (always splashScreen) Nothing
