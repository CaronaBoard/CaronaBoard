module Layout.View.Layout exposing (layout)

import Layout.Styles exposing (Classes(..), class)
import Layout.View.Header exposing (header)
import Model exposing (Model)
import Msg exposing (Msg)
import Testable.Html exposing (Html, div, text)


layout : Model -> Html Msg -> Html Msg
layout model html =
    div [ class Page ]
        [ header model.layout
        , html
        , notification model
        ]


notification : Model -> Html Msg
notification model =
    case model.layout.notification of
        Just notification ->
            div [ class NotificationVisible ] [ text notification ]

        Nothing ->
            div [ class NotificationHidden ] []
