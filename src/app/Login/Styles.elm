module Login.Styles exposing (Classes(..), className, namespace, styles)

import Common.Colors exposing (..)
import Common.CssHelpers exposing (..)
import Css exposing (..)
import Css.Foreign exposing (..)
import DEPRECATED.Css.File exposing (..)
import DEPRECATED.Css.Namespace
import Html exposing (Attribute)
import Layout.Styles exposing (button, linkButton)


namespace : String
namespace =
    "login"


className : Classes -> Attribute msg
className =
    namespacedClass namespace


type Classes
    = Page
    | Background
    | Container
    | Icon
    | SubmitButton
    | ResetPasswordButton
    | StepTitle
    | StepForm
    | PasswordStep
    | FilledEmail


styles : Stylesheet
styles =
    (stylesheet << DEPRECATED.Css.Namespace.namespace namespace)
        [ class Page
            [ height (pct 100)
            , width (pct 100)
            , position absolute
            , margin2 (pct 0) auto
            ]
        , class Background
            [ backgroundImage (url "static/images/streets.svg")
            , backgroundColor primaryBlue
            , backgroundSize cover
            , textAlign center
            , lightTextColor
            , height (pct 100)
            , width (pct 100)
            ]
        , class Container
            [ displayFlex
            , justifyContent spaceBetween
            , flexDirection column
            , height (pct 100)
            , property "background" "linear-gradient(rgb(52, 103, 255) 0%, rgba(52, 103, 255, .96) 50%, rgba(52, 103, 255, .9) 100%)"
            , overflow hidden
            ]
        , class Icon
            [ display none
            ]
        , class StepTitle step
        , class StepForm <|
            step
                ++ [ flexGrow (int 2)
                   , displayFlex
                   , flexDirection column
                   , justifyContent spaceBetween
                   ]
        , class PasswordStep
            [ property "animation" "slide-in 0.5s forwards"
            ]
        , slideInAnimation
        , class FilledEmail
            [ textAlign left
            ]
        , class ResetPasswordButton
            linkButton
        , desktopStyles
        ]


step : List Style
step =
    [ padding (px 40)
    , descendants
        [ h1
            [ fontSize (px 32)
            ]
        , input
            [ borderBottom3 (px 1) solid white
            ]
        , label
            [ lightTextColor
            ]
        , class SubmitButton <|
            Layout.Styles.button
                ++ [ color primaryBlue
                   , backgroundColor white
                   , hover
                        [ backgroundColor grey
                        ]
                   ]
        ]
    ]


slideInAnimation : Snippet
slideInAnimation =
    -- TODO: This below is a very hacky way of adding import Css.Foreign, waiting for elm-css to add support for it
    selector "@keyframes slide-in {"
        [ descendants
            [ selector "0%"
                [ opacity (int 0)
                , property "} /*" ""
                ]
            , selector "*/ 10%"
                [ opacity (int 1)
                , transform (translateX (pct 150))
                , property "} /*" ""
                ]
            , selector "*/ to"
                [ transform (translateX (pct 0))
                , property "} /*" "*/"
                ]
            ]
        ]


desktopStyles : Snippet
desktopStyles =
    mediaQuery [ "(min-width: 1200px)" ]
        [ class Page centralizeContents
        , class Background
            [ maxHeight (px 680)
            , maxWidth (px 945)
            , boxShadow4 (Css.em 0) (Css.em 0.3) (Css.em 1.2) (rgba 0 0 0 0.5)
            ]
        , class Container
            [ flexWrap wrap
            ]
        , class Icon
            [ display block
            , descendants
                [ selector ".layoutMaterialIcon"
                    [ fontSize (px 80)
                    ]
                ]
            ]
        , class StepTitle <|
            stepDesktop
                ++ centralizeContents
                ++ [ flexDirection column ]
        , class StepForm <|
            stepDesktop
                ++ [ backgroundColor (rgb 255 255 255)
                   , darkTextColor
                   , justifyContent spaceAround
                   ]
        ]


stepDesktop : List Style
stepDesktop =
    [ width (pct 50)
    , height (pct 100)
    , descendants
        [ input
            [ borderBottom3 (px 1) solid primaryBlack
            ]
        , label
            [ darkTextColor
            ]
        , class SubmitButton <|
            buttonDesktop
                ++ [ backgroundColor primaryBlue
                   , lightTextColor
                   , hover
                        [ backgroundColor lighterBlue
                        ]
                   ]
        , class ResetPasswordButton <|
            linkButton
                ++ buttonDesktop
        ]
    ]


buttonDesktop : List Style
buttonDesktop =
    [ width (pct 100)
    , darkTextColor
    ]


centralizeContents : List Style
centralizeContents =
    [ displayFlex
    , alignItems center
    , justifyContent center
    ]
