module Login.View.Layout exposing (loginLayout)

import Common.CssHelpers exposing (materializeClass)
import Login.Styles exposing (Classes(Page), class)
import Msg exposing (Msg)
import Testable.Html exposing (div)


loginLayout : Testable.Html.Html Msg -> Testable.Html.Html Msg
loginLayout child =
    div [ class Page, materializeClass "row" ]
        [ child ]
