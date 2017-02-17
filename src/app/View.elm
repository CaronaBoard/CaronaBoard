module View exposing (view, initialView)

import Testable
import Testable.Html exposing (div)
import Html
import Model exposing (Model, init)
import Msg exposing (Msg)
import Layout.Home
import Layout.SplashScreen exposing (splashScreen)


view : Model -> Testable.Html.Html Msg
view =
    Layout.Home.view


initialView : Html.Html Msg
initialView =
    Testable.view (always splashScreen) Nothing
