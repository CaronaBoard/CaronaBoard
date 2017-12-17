module Notifications.View.Notice exposing (notice)

import Html.Styled exposing (Html, div, styled, text)
import Model exposing (Model, Msg)
import Notifications.Styles exposing (..)


notice : Model -> Html Msg
notice model =
    case model.notifications.notice of
        Just notification ->
            styled div noticeVisible [] [ text notification ]

        Nothing ->
            styled div noticeHidden [] []
