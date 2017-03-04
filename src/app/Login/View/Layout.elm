module Login.View.Layout exposing (loginLayout)

import Testable.Html exposing (div)
import Testable.Html.Attributes exposing (id, class)
import Msg exposing (Msg)
import Login.Styles exposing (scopedClass, Classes(Page))


loginLayout : Testable.Html.Html Msg -> Testable.Html.Html Msg
loginLayout child =
    div [ scopedClass [ Page ], class "row" ]
        [ child ]
