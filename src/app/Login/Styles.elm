module Login.Styles exposing (..)

import Common.Colors exposing (..)
import Common.CssHelpers exposing (..)
import Css exposing (..)
import Css.Foreign exposing (..)
import Css.Media as Media exposing (only, screen, withMedia)
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


desktopSize : List Style -> Style
desktopSize =
    withMedia [ only screen [ Media.minWidth (px 1200) ] ]


page : List Style
page =
    [ height (pct 100)
    , width (pct 100)
    , position absolute
    , margin2 (pct 0) auto
    , desktopSize centralizeContents
    ]


background : List Style
background =
    [ backgroundImage (url "static/images/streets.svg")
    , backgroundColor primaryBlue
    , backgroundSize cover
    , textAlign center
    , lightTextColor
    , height (pct 100)
    , width (pct 100)
    , desktopSize
        [ maxHeight (px 680)
        , maxWidth (px 945)
        , boxShadow4 (Css.em 0) (Css.em 0.3) (Css.em 1.2) (rgba 0 0 0 0.5)
        ]
    ]


container : List Style
container =
    [ displayFlex
    , justifyContent spaceBetween
    , flexDirection column
    , height (pct 100)
    , property "background" "linear-gradient(rgb(52, 103, 255) 0%, rgba(52, 103, 255, .96) 50%, rgba(52, 103, 255, .9) 100%)"
    , overflow hidden
    , desktopSize
        [ flexWrap wrap ]
    ]


icon : List Style
icon =
    [ display none
    , desktopSize [ display block ]
    ]


bigIcon : List Style
bigIcon =
    [ fontSize (px 80) ]


stepTitle : List Style
stepTitle =
    step
        ++ [ desktopSize
                (stepDesktop
                    ++ centralizeContents
                    ++ [ flexDirection column ]
                )
           ]


stepForm : List Style
stepForm =
    step
        ++ [ flexGrow (int 2)
           , displayFlex
           , flexDirection column
           , justifyContent spaceBetween
           , desktopSize
                (stepDesktop
                    ++ [ backgroundColor (rgb 255 255 255)
                       , darkTextColor
                       , justifyContent spaceAround
                       ]
                )
           ]


passwordStep : List Style
passwordStep =
    [ property "animation" "slide-in 0.5s forwards" ]


filledEmail : List Style
filledEmail =
    [ textAlign left ]


submitButton : List Style
submitButton =
    Layout.Styles.button
        ++ [ desktopSize
                (buttonDesktop
                    ++ [ backgroundColor primaryBlue
                       , lightTextColor
                       ]
                )
           , color primaryBlue
           , backgroundColor white
           , hover
                [ backgroundColor lighterBlue
                ]
           ]


styles : Stylesheet
styles =
    (stylesheet << DEPRECATED.Css.Namespace.namespace namespace)
        [ class Page page
        , class Background background
        , class Container container
        , class Icon icon
        , class StepTitle stepTitle
        , class StepForm stepForm
        , class PasswordStep passwordStep
        , slideInAnimation
        , class FilledEmail filledEmail
        , class ResetPasswordButton linkButton
        ]


step : List Style
step =
    [ padding (px 40)
    , descendants
        [ h1
            [ fontSize (px 32)
            ]
        ]
    ]


stepInput : List Style
stepInput =
    [ borderBottom3 (px 1) solid white
    , desktopSize
        [ borderBottom3 (px 1) solid primaryBlack
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


resetPasswordButton : List Style
resetPasswordButton =
    linkButton
        ++ [ desktopSize
                (linkButton ++ buttonDesktop)
           ]


stepDesktop : List Style
stepDesktop =
    [ width (pct 50)
    , height (pct 100)
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
