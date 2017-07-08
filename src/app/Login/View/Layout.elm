module Login.View.Layout exposing (loginLayout)

import Html exposing (div)
import Login.Styles exposing (Classes(Page), className)
import Model exposing (Msg)


loginLayout : Html.Html Msg -> Html.Html Msg
loginLayout child =
    div [ className Page ]
        [ child ]
