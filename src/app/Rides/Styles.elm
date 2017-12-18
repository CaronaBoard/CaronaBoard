module Rides.Styles exposing (..)

import Common.Colors exposing (..)
import Common.CssHelpers exposing (..)
import Css exposing (..)
import Html.Styled exposing (..)


contact : StyledElement msg
contact =
    styled div [ fontSize (px 24) ]


otherDetails : StyledElement msg
otherDetails =
    styled div
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


path : StyledElement msg
path =
    styled div [ marginBottom (px 10) ]


pathIcon : StyledElement msg
pathIcon =
    styled div
        [ position absolute
        , fontSize (px 16)
        , marginTop (px 10)
        , marginLeft (px 2)
        ]


pathIconDot : StyledElement msg
pathIconDot =
    styled span
        [ fontSize (px 10)
        , marginLeft (px 5)
        , marginRight (px 5)
        ]


rideInfo : StyledElement msg
rideInfo =
    styled ul [ margin (px 0) ]


rideInfoIcon : StyledElement msg
rideInfoIcon =
    styled span
        [ fontSize (px 16)
        , marginRight (px 5)
        , verticalAlign middle
        ]
