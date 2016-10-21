module App exposing (..)

import Html exposing (Html, div, text, h3, a)
import Html.App as App
import Html.Attributes exposing (id, class, href, target)
import App.Header exposing (header)
import Instructions.Instructions exposing (instructions)
import RoutesBox.RoutesBox exposing (routesBox)


main : Program Never
main =
    App.beginnerProgram { model = Nothing, view = view, update = \_ _ -> Nothing }


view : a -> Html a
view model =
    div [ id "app-main" ]
        [ header
        , instructions
        , routesBox
        ]
