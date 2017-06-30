module Login.View.Layout exposing (loginLayout)

import Common.CssHelpers exposing (materializeClass)
import Login.Styles exposing (Classes(Page), className)
import Model exposing (Msg)
import Html exposing (div)


loginLayout : Html.Html Msg -> Html.Html Msg
loginLayout child =
    div [ className Page, materializeClass "row" ]
        [ child ]
