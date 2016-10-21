module RoutesBox exposing (..)

import Html exposing (Html, div, text, h3, a)
import Html.App as App
import Html.Attributes exposing (id, class, href, target)
import Routesbox.RoutesTable exposing (routesTable)
import Routesbox.FeedbackBox exposing (feedbackBox)


main : Program Never
main =
    App.beginnerProgram { model = Nothing, view = view, update = \_ _ -> Nothing }


view : a -> Html a
view model =
    div [ class "routes-box" ]
        [ routesTable
        , feedbackBox
        ]
