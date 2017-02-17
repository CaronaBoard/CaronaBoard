module Layout.Home exposing (view)

import Testable.Html exposing (Html, div)
import Testable.Html.Attributes exposing (id, class)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Layout.Header exposing (header)
import Instructions.Instructions exposing (instructions)
import Rides.RoutesList exposing (routesList)
import Login.View.Login exposing (login)
import UrlRouter.Routes exposing (Page(..))
import Layout.SplashScreen exposing (splashScreen)


view : Model -> Html Msg
view model =
    div [ id "app" ]
        [ routeRender model ]


routeRender : Model -> Html Msg
routeRender model =
    case model.urlRouter.page of
        HomeRoute ->
            splashScreen

        LoginRoute ->
            div [ id "app-login" ]
                [ div [ class "row" ]
                    [ Testable.Html.map MsgForLogin <| login model.login ]
                ]

        _ ->
            div [ id "app-main" ]
                [ header
                , instructions
                , routesList model.rides
                ]
