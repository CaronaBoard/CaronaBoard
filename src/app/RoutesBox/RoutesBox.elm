module RoutesBox.RoutesBox exposing (routesBox)

import Testable.Html exposing (Html, div, text, h3, a)
import Testable.Html.Attributes exposing (id, class, href, target)
import RoutesBox.RoutesTable exposing (routesTable)
import RoutesBox.FeedbackBox exposing (feedbackBox)
import Model exposing (Model)


routesBox : Model -> Html a
routesBox model =
    div [ class "routes-box" ]
        [ routesTable model
        , feedbackBox
        ]
