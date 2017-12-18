module Profile.Styles exposing (..)

import Common.CssHelpers exposing (StyledElement)
import Css exposing (..)
import Html.Styled exposing (..)


contactField : StyledElement msg
contactField =
    styled div
        [ displayFlex
        , justifyContent spaceBetween
        ]


contactKind : StyledElement msg
contactKind =
    styled div [ width (pct 40) ]


contactValue : StyledElement msg
contactValue =
    styled div [ width (pct 60) ]
