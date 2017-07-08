module Common.Colors exposing (..)

import Css exposing (Color, Mixin, color, rgb)


darkTextColor : Mixin
darkTextColor =
    color primaryBlack


lightTextColor : Mixin
lightTextColor =
    color white


primaryBlue : Color
primaryBlue =
    rgb 52 103 255


lighterBlue : Color
lighterBlue =
    rgb 80 130 255


primaryBlack : Color
primaryBlack =
    rgb 85 85 85


white : Color
white =
    rgb 255 255 255


grey : Color
grey =
    rgb 240 240 240


darkerGrey : Color
darkerGrey =
    rgb 180 180 180


primaryRed : Color
primaryRed =
    rgb 255 50 50
