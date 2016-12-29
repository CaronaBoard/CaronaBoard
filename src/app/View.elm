module View exposing (view, initialView)

import Html exposing (Html, div)
import Model exposing (Model, init)
import Msg exposing (Msg)
import Layout.Home


view : Model -> Html Msg
view =
    Layout.Home.view


initialView : Html Msg
initialView =
    view (Tuple.first init)
