module Login.Styles exposing (styles, Classes(..), class, namespace)

import Css exposing (..)
import Css.Elements exposing (h1, input, label)
import Css.Namespace
import Common.Colors exposing (..)
import Common.CssHelpers exposing (..)


{ class, namespace } =
    withNamespace "login"


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
    (stylesheet << Css.Namespace.namespace namespace)
        [ cssClass Page
            [ height (pct 100)
            , width (pct 100)
            , position absolute
            , margin2 (pct 0) auto
            ]
        , cssClass Background
            [ backgroundImage (url "images/streets.svg")
            , backgroundColor primaryBlue
            , backgroundSize cover
            , textAlign center
            , lightTextColor
            , height (pct 100)
            ]
        , cssClass Container
            [ displayFlex
            , justifyContent spaceBetween
            , flexDirection column
            , height (pct 100)
            , property "background" "linear-gradient(rgb(52, 103, 255) 0%, rgba(52, 103, 255, .96) 50%, rgba(52, 103, 255, .9) 100%)"
            , overflow hidden
            ]
        , cssClass Icon
            [ display none
            ]
        , cssClass StepTitle step
        , cssClass StepForm <|
            step
                ++ [ flexGrow (int 2)
                   , displayFlex
                   , flexDirection column
                   , justifyContent spaceBetween
                   ]
        , cssClass PasswordStep
            [ property "animation" "slide-in 0.5s forwards"
            ]
        , slideInAnimation
        , cssClass FilledEmail
            [ textAlign left
            ]
        , desktopStyles
        ]


step : List Mixin
step =
    [ padding (px 40)
    , descendants
        [ h1
            [ fontSize (px 32)
            ]
        , input
            [ important <| borderBottom3 (px 1) solid white
            ]
        , label
            [ important <| lightTextColor
            ]
        , cssClass SubmitButton <|
            button
                ++ [ color primaryBlue
                   , backgroundColor white
                   , hover
                        [ backgroundColor grey
                        ]
                   ]
        , cssClass ResetPasswordButton button
        ]
    ]


button : List Mixin
button =
    [ width (pct 100)
    , lightTextColor
    ]


slideInAnimation : Snippet
slideInAnimation =
    -- TODO: This below is a very hacky way of adding keyframes, waiting for elm-css to add support for it
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
    mediaQuery "(min-width: 1200px)"
        [ cssClass Page centralizeContents
        , cssClass Background
            [ maxHeight (px 680)
            , maxWidth (px 945)
            , boxShadow4 (em 0) (em 0.3) (em 1.2) (rgba 0 0 0 0.5)
            ]
        , cssClass Container
            [ flexWrap wrap
            ]
        , cssClass Icon
            [ display block
            , descendants
                [ selector ".material-icons"
                    [ fontSize (px 80)
                    ]
                ]
            ]
        , cssClass StepTitle <|
            stepDesktop
                ++ centralizeContents
                ++ [ flexDirection column ]
        , cssClass StepForm <|
            stepDesktop
                ++ [ backgroundColor (rgb 255 255 255)
                   , darkTextColor
                   , justifyContent spaceAround
                   ]
        ]


stepDesktop : List Mixin
stepDesktop =
    [ width (pct 50)
    , height (pct 100)
    , descendants
        [ input
            [ important <| borderBottom3 (px 1) solid primaryBlack
            ]
        , label
            [ important darkTextColor
            ]
        , cssClass SubmitButton <|
            buttonDesktop
                ++ [ backgroundColor primaryBlue
                   , lightTextColor
                   , hover
                        [ backgroundColor lighterBlue
                        ]
                   ]
        , cssClass ResetPasswordButton buttonDesktop
        ]
    ]


buttonDesktop : List Mixin
buttonDesktop =
    [ width (pct 100)
    , darkTextColor
    ]


centralizeContents : List Mixin
centralizeContents =
    [ displayFlex
    , alignItems center
    , justifyContent center
    ]
