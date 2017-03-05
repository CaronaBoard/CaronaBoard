module Login.View.Layout exposing (loginLayout)

import Testable.Html exposing (div)
import Msg exposing (Msg)
import Login.Styles exposing (class, Classes(Page))
import Common.CssHelpers exposing (materializeClass)


loginLayout : Testable.Html.Html Msg -> Testable.Html.Html Msg
loginLayout child =
    div [ class Page, materializeClass "row" ]
        [ child ]
