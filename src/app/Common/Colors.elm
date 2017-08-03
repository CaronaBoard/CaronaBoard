module Common.Colors exposing (..)

import Css exposing (Color, Mixin, color, hex, rgb)


darkTextColor : Mixin
darkTextColor =
    color primaryBlack


lightTextColor : Mixin
lightTextColor =
    color white


linkColor : Mixin
linkColor =
    color (hex "#039be5")


primaryBlue : Color
primaryBlue =
    rgb 52 103 255


lighterBlue : Color
lighterBlue =
    rgb 80 130 255


darkerBlue : Color
darkerBlue =
    rgb 0 50 200


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
