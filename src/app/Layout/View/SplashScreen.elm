module Layout.View.SplashScreen exposing (splashScreen)

import Common.Colors exposing (..)
import Css exposing (..)
import DEPRECATED.Css exposing (asPairs)
import Html exposing (Html, div, img)
import Html.Attributes exposing (src, style)
import Model exposing (Msg(..))


splashScreen : Html Msg
splashScreen =
    div [ style splashScreenStyle ]
        [ img
            [ Html.Attributes.src "static/images/logo.svg"
            , style splashIconStyle
            ]
            []
        ]


splashScreenStyle : List ( String, String )
splashScreenStyle =
    asPairs
        [ width (pct 100)
        , height (pct 100)
        , top (px 0)
        , left (px 0)
        , position fixed
        , backgroundColor primaryBlue
        , displayFlex
        , justifyContent center
        , alignItems center
        ]


splashIconStyle : List ( String, String )
splashIconStyle =
    asPairs
        [ width (px 192)
        , height (px 192)
        ]
