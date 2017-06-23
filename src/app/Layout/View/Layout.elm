module Layout.View.Layout exposing (layout)

import Layout.View.Header exposing (header)
import Model exposing (Model)
import Msg exposing (Msg)
import Rides.Styles exposing (Classes(Page), class)
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
            div [] [ text notification ]

        Nothing ->
            div [] []
