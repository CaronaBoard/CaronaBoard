module Rides.Styles exposing (..)

import Common.Colors exposing (..)
import Css exposing (..)
import Css.Foreign exposing (..)


contact : List Style
contact =
    [ fontSize (px 24) ]


otherDetails : List Style
otherDetails =
    [ displayFlex
    , justifyContent spaceBetween
    , alignItems flexEnd
    , borderTop3 (px 1) solid grey
    , paddingTop (px 15)
    ]


actionButton : List Style
actionButton =
    [ darkTextColor
    , margin (px 0)
    , backgroundColor (hex "#EEE")
    , borderStyle none
    , padding2 (px 10) (px 15)
    , hover
        [ backgroundColor (hex "#DDD")
        ]
    ]


path : List Style
path =
    [ marginBottom (px 10) ]


pathIcon : List Style
pathIcon =
    [ descendants
        [ selector ".layoutMaterialIcon"
            [ position absolute
            , fontSize (px 16)
            , marginTop (px 10)
            , marginLeft (px 2)
            ]
        ]
    ]


pathIconDot : List Style
pathIconDot =
    [ descendants
        [ selector ".layoutMaterialIcon"
            [ fontSize (px 10)
            , marginLeft (px 5)
            , marginRight (px 5)
            ]
        ]
    ]


rideInfo : List Style
rideInfo =
    [ margin (px 0) ]
