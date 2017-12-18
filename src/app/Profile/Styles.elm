module Profile.Styles exposing (..)

import Css exposing (..)


contactField : List Style
contactField =
    [ displayFlex
    , justifyContent spaceBetween
    ]


contactKind : List Style
contactKind =
    [ width (pct 40) ]


contactValue : List Style
contactValue =
    [ width (pct 60) ]
