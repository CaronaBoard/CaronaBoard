module View exposing (view, initialView, homeLocation)

import Testable
import Testable.Html exposing (div)
import Html
import Model exposing (Model, init)
import Msg exposing (Msg)
import Layout.Home
import Navigation exposing (Location)


view : Model -> Testable.Html.Html Msg
view =
    Layout.Home.view


homeLocation : Location
homeLocation =
    { href = "", host = "", hostname = "", protocol = "", origin = "", port_ = "", pathname = "", search = "", hash = "", username = "", password = "" }


initialView : Html.Html Msg
initialView =
    init { currentUser = Nothing } homeLocation
        |> Tuple.first
        |> Testable.view view
