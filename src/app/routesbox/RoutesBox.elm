module RoutesBox.RoutesBox exposing (routesBox)

import Html exposing (Html, div, text, h3, a)
import Html.Attributes exposing (id, class, href, target)
import Routesbox.RoutesTable exposing (routesTable)
import Routesbox.FeedbackBox exposing (feedbackBox)
import Model exposing (Model)


routesBox : Model -> Html a
routesBox model =
    div [ class "routes-box" ]
        [ routesTable model
        , feedbackBox
        ]
