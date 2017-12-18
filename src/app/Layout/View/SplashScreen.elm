module Layout.View.SplashScreen exposing (splashScreen)

import Common.Colors exposing (..)
import Css exposing (..)
import Html.Styled exposing (Html, div, img, toUnstyled)
import Html.Styled.Attributes exposing (css, src)
import Model exposing (Msg(..))


splashScreen : Html Msg
splashScreen =
    div [ css splashScreenStyle ]
        [ img [ src "static/images/logo.svg", css splashIconStyle ] []
        ]


splashScreenStyle : List Style
splashScreenStyle =
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


splashIconStyle : List Style
splashIconStyle =
    [ width (px 192)
    , height (px 192)
    ]
