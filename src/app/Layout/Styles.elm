module Layout.Styles exposing (..)

import Common.Colors exposing (..)
import Css exposing (..)
import Css.Foreign exposing (..)
import DEPRECATED.Css.File exposing (..)
import DEPRECATED.Css.Namespace


namespace : String
namespace =
    "layout"


styles : Stylesheet
styles =
    (stylesheet << DEPRECATED.Css.Namespace.namespace namespace) generalStyles


generalStyles : List Snippet
generalStyles =
    [ html
        [ -- source: https://www.smashingmagazine.com/2015/11/using-system-ui-fonts-practical-guide/
          fontFamilies [ "-apple-system", "BlinkMacSystemFont", "Segoe UI", "Roboto", "Oxygen", "Ubuntu", "sans-serif" ]
        , fontSize (px 14)
        , property "line-height" "1.5"
        , fontWeight normal
        ]
    , body
        [ backgroundColor grey
        , margin (px 0)
        ]
    , selector "*"
        [ boxSizing borderBox
        ]
    , ul
        [ paddingLeft (px 0)
        , listStyleType none
        ]
    , a
        [ textDecoration none
        , linkColor
        ]
    , h1
        [ fontWeight normal
        ]
    , input
        [ borderStyle none
        , borderBottom3 (px 1) solid darkerGrey
        , marginBottom (px 20)
        , height (px 42)
        , width (pct 100)
        , backgroundColor transparent
        , color inherit
        , outline none
        ]
    , select
        [ height (px 42)
        , width (pct 100)
        , fontSize (Css.rem 1.1)
        ]

    -- TODO: This below is a very hacky way of adding import Css.Foreign, waiting for elm-css to add support for it
    , selector "@keyframes slideDown {"
        [ descendants
            [ selector "from"
                [ maxHeight (px 0)
                , opacity (int 0)
                , property "} /*" ""
                ]
            , selector "*/ to"
                [ maxHeight (px 150)
                , opacity (int 1)
                , property "} /*" "*/"
                ]
            ]
        ]
    , -- TODO: This below is a very hacky way of adding import Css.Foreign, waiting for elm-css to add support for it
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
    ]


header : List Style
header =
    [ height (px 54)
    ]


navbar : List Style
navbar =
    [ backgroundColor primaryBlue
    , position fixed
    , displayFlex
    , justifyContent spaceBetween
    , width (pct 100)
    , lightTextColor
    , height (px 56)
    , lineHeight (px 56)
    , cardShadow
    , children
        [ ul
            [ margin (px 0)
            , displayFlex
            ]
        ]
    ]


navbarMaterialIcon : List Style
navbarMaterialIcon =
    [ fontSize (px 24) ]


brandLogo : List Style
brandLogo =
    [ fontSize (Css.rem 1.4)
    , lightTextColor
    , position absolute
    , textAlign center
    , width (pct 100)
    , cursor pointer
    ]


navBack : List Style
navBack =
    menuButton
        ++ [ children
                [ selector ".layoutMaterialIcon"
                    [ fontSize (px 30)
                    ]
                ]
           ]


pageTitle : List Style
pageTitle =
    [ darkTextColor
    , fontSize (px 34)
    ]


submitButton : List Style
submitButton =
    button


disabledButton : List Style
disabledButton =
    button
        ++ [ backgroundColor grey
           , color darkerGrey
           , hover
                [ backgroundColor grey
                ]
           ]


disabledLinkButton : List Style
disabledLinkButton =
    linkButton
        ++ [ color darkerGrey
           ]


buttonContainer : List Style
buttonContainer =
    [ displayFlex
    , justifyContent center
    ]


menu : List Style
menu =
    [ position fixed
    , width (pct 100)
    , height (pct 100)
    , zIndex (int 998)
    ]


animatedDropdown : List Style
animatedDropdown =
    card
        ++ [ padding (px 0)
           , margin (px 10)
           , display block
           , top (px 0)
           , right (px 0)
           , width auto
           , opacity (int 1)
           , overflow hidden
           , property "animation" "slideDown 0.3s"
           , backgroundColor white
           , position absolute
           , zIndex (int 999)
           ]


dropdownLink : List Style
dropdownLink =
    [ padding2 (px 10) (px 15)
    , fontSize (px 16)
    , display block
    , hover
        [ backgroundColor grey
        ]
    ]


addRideLink : List Style
addRideLink =
    menuButton
        ++ [ displayFlex
           , alignItems center
           ]


errorMessage : List Style
errorMessage =
    [ lightTextColor
    , backgroundColor primaryRed
    , padding2 (px 5) (px 15)
    , borderRadius (px 17)
    , fontSize (px 14)
    , display inlineBlock
    , marginBottom (px 20)
    ]


cardTitle : List Style
cardTitle =
    [ fontSize (px 16)
    , fontWeight bold
    ]


inputField : List Style
inputField =
    [ position relative
    , marginTop (px 15)
    , descendants
        [ selector "label"
            [ top (px -10)
            , left (px 0)
            , fontSize (pct 80)
            , position absolute
            , property "transition" ".2s ease-out"
            ]
        , selector "input"
            [ fontSize (Css.rem 1.1)
            ]
        , selector "input:placeholder-shown:not(:focus) + label"
            [ fontSize (Css.rem 1.1)
            , top (px 10)
            ]
        ]
    ]


selectWrapper : List Style
selectWrapper =
    [ displayFlex
    , alignItems center
    , marginRight (px 15)
    , descendants
        [ select
            [ backgroundColor transparent
            , borderStyle none
            , borderBottom3 (px 1) solid (hex "#FFF")
            , marginTop (px 1)
            , display block
            , property "-webkit-appearance" "none"
            , property "-moz-appearance" "none"
            ]
        ]
    ]


selectCaret : List Style
selectCaret =
    [ fontSize (px 10)
    ]


materialIconLeft : List Style
materialIconLeft =
    materialIcon
        ++ [ float left ]


materialIconRight : List Style
materialIconRight =
    materialIcon
        ++ [ float right ]


button : List Style
button =
    [ width (pct 100)
    , backgroundColor primaryBlue
    , lightTextColor
    , borderRadius (px 54)
    , lineHeight (px 54)
    , height (px 54)
    , borderStyle none
    , cursor pointer
    , fontSize (px 14)
    , hover
        [ backgroundColor lighterBlue
        ]
    ]


linkButton : List Style
linkButton =
    button
        ++ [ backgroundColor transparent
           , hover
                [ backgroundColor transparent
                ]
           ]


container : List Style
container =
    [ padding2 (px 0) (px 20)
    , maxWidth (px 1024)
    , margin2 (px 0) auto
    ]


card : List Style
card =
    [ backgroundColor white
    , padding (px 20)
    , cardShadow
    , marginBottom (px 15)
    , darkTextColor
    ]


cardShadow : Style
cardShadow =
    boxShadow4 (px 1) (px 1) (px 3) (rgba 0 0 0 0.3)


materialIcon : List Style
materialIcon =
    [ fontFamilies [ "Material Icons" ]
    , fontStyle normal
    ]


menuButton : List Style
menuButton =
    [ lightTextColor
    , padding2 (px 0) (px 15)
    , display block
    , height (px 56)
    , position relative
    , zIndex (int 1)
    , cursor pointer
    , hover
        [ backgroundColor (rgba 0 0 0 0.1)
        ]
    ]
