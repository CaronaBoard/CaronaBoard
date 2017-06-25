module Notifications.View.Notice exposing (notice)

import Model exposing (Model)
import Msg exposing (Msg)
import Notifications.Styles exposing (Classes(..), class)
import Testable.Html exposing (Html, div, text)


notice : Model -> Html Msg
notice model =
    case model.notifications.notice of
        Just notification ->
            div [ class NoticeVisible ] [ text notification ]

        Nothing ->
            div [ class NoticeHidden ] []
