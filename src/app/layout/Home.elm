module Layout.Home exposing (view)

import Html exposing (Html, div)
import Html.Attributes exposing (id)
import Model exposing (Model, Rider)
import Msg exposing (Msg)
import Layout.Header exposing (header)
import Instructions.Instructions exposing (instructions)
import RoutesBox.RoutesBox exposing (routesBox)


view : Model -> Html Msg
view model =
    div [ id "app-main" ]
        [ header
        , instructions
        , routesBox model
        ]
