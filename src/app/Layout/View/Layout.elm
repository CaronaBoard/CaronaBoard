module Layout.View.Layout exposing (layout)

import Html
import Html.Styled exposing (Html, div, fromUnstyled, text, toUnstyled)
import Html.Styled.Attributes exposing (id)
import Layout.View.Header exposing (header)
import Model exposing (Model, Msg)
import Notifications.View.Notice exposing (notice)


layout : Model -> Html.Html Msg -> Html.Html Msg
layout model html =
    div [ id "page" ]
        [ header model
        , fromUnstyled html
        , notice model
        ]
        |> toUnstyled


styledLayout : Model -> Html.Styled.Html Msg -> Html Msg
styledLayout model html =
    div []
        [ header model
        , html
        , notice model
        ]
