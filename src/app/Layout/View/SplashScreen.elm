module Layout.View.SplashScreen exposing (splashScreen)

import Common.Colors exposing (..)
import Css exposing (..)
import Model exposing (Msg(..))
import Html exposing (Html, div)
import Html.Attributes exposing (style)


splashScreen : Html Msg
splashScreen =
    div [ style splashScreenStyle ] []


splashScreenStyle : List ( String, String )
splashScreenStyle =
    asPairs
        [ width (pct 100)
        , height (pct 100)
        , top (px 0)
        , left (px 0)
        , position fixed
        , backgroundImage (url "static/images/logo.svg")
        , backgroundColor primaryBlue
        , backgroundRepeat noRepeat
        , backgroundPosition center
        , backgroundSize2 (px 192) (px 192)
        ]
