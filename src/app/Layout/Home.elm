module Layout.Home exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Model exposing (Model, Rider)
import Msg exposing (Msg)
import Layout.Header exposing (headerapp)
import Login.Login exposing (login)
import Instructions.Instructions exposing (instructions)
import RoutesBox.RoutesBox exposing (routesBox)

view : Model -> Html Msg
view model =
    div [ id "app" ] [
    div [ id "app-login" ]
        [ login ]
    , div [ id "app-main" ]
        [ headerapp
        , instructions
        , routesBox model
        ]
    ]