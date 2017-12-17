module Layout.View.Layout exposing (layout)

import Html exposing (Html, div, text)
import Html.Styled
import Layout.Styles exposing (Classes(..), layoutClass)
import Layout.View.Header exposing (header)
import Model exposing (Model, Msg)
import Notifications.View.Notice exposing (notice)


layout : Model -> Html Msg -> Html Msg
layout model html =
    div [ layoutClass Page ]
        [ Html.Styled.toUnstyled (header model)
        , html
        , notice model
        ]
