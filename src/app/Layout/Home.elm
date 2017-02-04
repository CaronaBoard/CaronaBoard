module Layout.Home exposing (view)

import Html exposing (Html, div)
import Html.Attributes exposing (id)
import Model exposing (Model, Rider)
import Msg exposing (Msg)
import Layout.Header exposing (header)
import Instructions.Instructions exposing (instructions)
import RoutesBox.RoutesBox exposing (routesBox)
import Login.View.Login exposing (login)
import Login.Model exposing (loggedInUser)


view : Model -> Html Msg
view model =
    div [ id "app" ]
        [ loginOrHomeScreen model ]


loginOrHomeScreen : Model -> Html Msg
loginOrHomeScreen model =
    case loggedInUser model.login of
        Just user ->
            div [ id "app-main" ]
                [ header
                , instructions
                , routesBox model
                ]

        Nothing ->
            div [ id "app-login" ]
                [ login model.login ]
