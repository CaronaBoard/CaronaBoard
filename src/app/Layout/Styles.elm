module Layout.Styles exposing (..)

import Common.Colors exposing (..)
import Common.CssHelpers exposing (..)
import Css exposing (..)
import Css.Foreign exposing (..)
import DEPRECATED.Css.File exposing (..)
import DEPRECATED.Css.Namespace
import Html exposing (Attribute)
import Html.Styled


namespace : String
namespace =
    "layout"


layoutClass : Classes -> Attribute msg
layoutClass =
    namespacedClass namespace


styledLayoutClass : class -> Html.Styled.Attribute msg
styledLayoutClass =
    styledNamespacedClass namespace


type Classes
    = Container
    | Menu
    | AnimatedDropdown
    | DropdownLink
    | Header
    | Navbar
    | BrandLogo
    | NavBack
    | SubmitButton
    | DisabledButton
    | LinkButton
    | DisabledLinkButton
    | ButtonContainer
    | MenuButton
    | SignOutButton
    | AddRideLink
    | PageTitle
    | ErrorMessage
    | Card
    | CardTitle
    | InputField
    | SelectField
    | SelectWrapper
    | SelectCaret
    | MaterialIcon
    | MaterialIconLeft
    | MaterialIconRight


styles : Stylesheet
styles =
    (stylesheet << DEPRECATED.Css.Namespace.namespace namespace)
        (generalStyles ++ layoutStyles)


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
    ]


header : List Style
header =
    [ height (px 54)
    ]


layoutStyles : List Snippet
layoutStyles =
    [ class Container
        container
    , class Header
        [ height (px 54)
        ]
    , class Navbar
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
        , descendants
            [ class MaterialIcon
                [ fontSize (px 24)
                ]
            ]
        ]
    , class MenuButton
        menuButton
    , class BrandLogo
        [ fontSize (Css.rem 1.4)
        , lightTextColor
        , position absolute
        , textAlign center
        , width (pct 100)
        , cursor pointer
        ]
    , class NavBack <|
        menuButton
            ++ [ children
                    [ selector ".layoutMaterialIcon"
                        [ fontSize (px 30)
                        ]
                    ]
               ]
    , class PageTitle
        [ darkTextColor
        , fontSize (px 34)
        ]
    , class SubmitButton
        button
    , class DisabledButton <|
        button
            ++ [ backgroundColor grey
               , color darkerGrey
               , hover
                    [ backgroundColor grey
                    ]
               ]
    , class LinkButton <|
        linkButton
    , class DisabledLinkButton <|
        linkButton
            ++ [ color darkerGrey
               ]
    , class ButtonContainer
        [ displayFlex
        , justifyContent center
        ]
    , class Menu
        [ position fixed
        , width (pct 100)
        , height (pct 100)
        , zIndex (int 998)
        ]
    , class AnimatedDropdown <|
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
    , class DropdownLink
        [ padding2 (px 10) (px 15)
        , fontSize (px 16)
        , display block
        , hover
            [ backgroundColor grey
            ]
        ]
    , class AddRideLink <|
        menuButton
            ++ [ displayFlex
               , alignItems center
               ]
    , class ErrorMessage
        [ lightTextColor
        , backgroundColor primaryRed
        , padding2 (px 5) (px 15)
        , borderRadius (px 17)
        , fontSize (px 14)
        , display inlineBlock
        , marginBottom (px 20)
        ]
    , class Card
        card
    , class CardTitle
        [ fontSize (px 16)
        , fontWeight bold
        ]
    , class InputField
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
    , class SelectField
        [ backgroundColor transparent
        , borderStyle none
        , borderBottom3 (px 1) solid (hex "#FFF")
        , marginTop (px 1)
        , display block
        , property "-webkit-appearance" "none"
        , property "-moz-appearance" "none"
        ]
    , class SelectWrapper
        [ displayFlex
        , alignItems center
        , marginRight (px 15)
        ]
    , class SelectCaret
        [ fontSize (px 10)
        ]
    , class MaterialIcon
        materialIcon
    , class MaterialIconLeft <|
        materialIcon
            ++ [ float left ]
    , class MaterialIconRight <|
        materialIcon
            ++ [ float right ]

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
    ]


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
