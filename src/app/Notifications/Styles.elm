module Notifications.Styles exposing (..)

import Common.Colors exposing (..)
import Css exposing (..)


noticeVisible : List Style
noticeVisible =
    notice ++ [ bottom (px 0) ]


noticeHidden : List Style
noticeHidden =
    notice ++ [ bottom (px -50) ]


notice : List Style
notice =
    [ width (pct 100)
    , height (px 50)
    , property "transition" "all 0.5s ease"
    , lightTextColor
    , backgroundColor (rgba 0 0 0 0.8)
    , displayFlex
    , alignItems center
    , padding (px 20)
    , position fixed
    ]
