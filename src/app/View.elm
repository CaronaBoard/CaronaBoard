module View exposing (view, staticView)

import Testable
import Testable.Html exposing (div, h1, text)
import Html
import Model exposing (Model, init)
import Msg exposing (Msg(MsgForLogin))
import Layout.View.SplashScreen exposing (splashScreen)
import UrlRouter.Routes exposing (Page(SplashScreenPage, LoginPage, RidesPage, NotFoundPage, PasswordResetPage))
import Login.View.Layout exposing (loginLayout)
import Login.View.Login exposing (login)
import Login.View.PasswordReset exposing (passwordReset)
import Layout.View.Header exposing (header)
import Rides.View.Instructions exposing (instructions)
import Rides.View.RoutesList exposing (routesList)
import Rides.Styles exposing (class, Classes(Page))


view : Model -> Testable.Html.Html Msg
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


staticView : Html.Html Msg
staticView =
    Testable.view (always splashScreen) Nothing
