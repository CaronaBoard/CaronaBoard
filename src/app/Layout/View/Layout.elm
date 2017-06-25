module Layout.View.Layout exposing (layout)

import Layout.Styles exposing (Classes(..), class)
import Layout.View.Header exposing (header)
import Model exposing (Model)
import Msg exposing (Msg)
import Notifications.View.Notice exposing (notice)
import Testable.Html exposing (Html, div, text)


layout : Model -> Html Msg -> Html Msg
layout model html =
    div [ class Page ]
        [ header model.layout
        , html
        , notice model
        ]
