module Layout.View.Layout exposing (layout)

import Layout.Styles exposing (Classes(..), layoutClass)
import Layout.View.Header exposing (header)
import Model exposing (Model, Msg)
import Notifications.View.Notice exposing (notice)
import Testable.Html exposing (Html, div, text)


layout : Model -> Html Msg -> Html Msg
layout model html =
    div [ layoutClass Page ]
        [ header model.layout
        , html
        , notice model
        ]
