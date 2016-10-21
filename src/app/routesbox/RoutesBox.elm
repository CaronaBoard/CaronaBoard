module RoutesBox.RoutesBox exposing (routesBox)

import Html exposing (Html, div, text, h3, a)
import Html.Attributes exposing (id, class, href, target)
import Routesbox.RoutesTable exposing (routesTable)
import Routesbox.FeedbackBox exposing (feedbackBox)


routesBox : Html a
routesBox =
    div [ class "routes-box" ]
        [ routesTable
        , feedbackBox
        ]
