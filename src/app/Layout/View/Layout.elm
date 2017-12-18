module Layout.View.Layout exposing (layout)

import Html.Styled exposing (Html, div, fromUnstyled, text, toUnstyled)
import Layout.View.Header exposing (header)
import Model exposing (Model, Msg)
import Notifications.View.Notice exposing (notice)


layout : Model -> Html.Styled.Html Msg -> Html Msg
layout model html =
    div []
        [ header model
        , html
        , notice model
        ]
