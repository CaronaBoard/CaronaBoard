module Layout.Styles exposing (..)

import Common.Colors exposing (..)
import Common.CssHelpers exposing (..)
import Css exposing (..)
import Css.Elements exposing (..)
import Css.Namespace
import Html exposing (Attribute)


namespace : String
namespace =
    "layout"


layoutClass : Classes -> Attribute msg
layoutClass =
    namespacedClass namespace


type Classes
    = Container
    | Page
    | Menu
    | AnimatedDropdown
    | Navbar
    | BrandLogo
    | SubmitButton
    | DisabledButton
    | ButtonContainer
    | OpenMenuButton
    | SignOutButton
    | AddRideLink
    | PageTitle
    | ErrorMessage
    | Card
    | CardTitle


styles : Stylesheet
styles =
    (stylesheet << Css.Namespace.namespace namespace)
        (generalStyles ++ layoutStyles)


generalStyles : List Snippet
generalStyles =
    [ html
        [ fontFamilies [ "Lato", sansSerif.value ]
        ]
    , body
        [ backgroundColor grey
        ]
    , selector ".input-field"
        [ descendants
            [ selector "label"
                [ important <| top (px -10)
                , important <| fontSize (pct 80)
                ]
            , selector "input"
                [ important <| fontSize (Css.rem 1.1)
                ]
            , selector "input:placeholder-shown:not(:focus) + *"
                [ important <| fontSize (Css.rem 1.1)
                , important <| top (px 10)
                ]
            ]
        ]
    ]


layoutStyles : List Snippet
layoutStyles =
    [ class Container
        container
    , class Page
        []
    , class Navbar
        [ backgroundColor primaryBlue
        ]
    , class BrandLogo
        [ fontSize (Css.rem 1.4)
        , marginLeft (px 20)
        ]
    , class PageTitle
        [ darkTextColor
        , fontSize (px 34)
        ]
    , class SubmitButton
        button
    , class DisabledButton <|
        button
            -- temporary importants for overwritting login buttons
            ++ [ important <| backgroundColor grey
               , important <| color darkerGrey
               , hover
                    [ important <| backgroundColor grey
                    ]
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
        , children
            [ class AnimatedDropdown
                [ margin (px 10)
                , display block
                , top (px 0)
                , right (px 0)
                , width auto
                , opacity (int 1)
                , overflow hidden
                , property "animation" "slideDown 0.3s"
                ]
            ]
        ]
    , class AddRideLink
        [ displayFlex
        , alignItems center
        , descendants
            [ selector "i"
                [ marginRight (px 10)
                ]
            ]
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

    -- TODO: This below is a very hacky way of adding keyframes, waiting for elm-css to add support for it
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


button : List Mixin
button =
    [ width (pct 100)
    , backgroundColor primaryBlue
    , lightTextColor
    , borderRadius (px 54)
    , lineHeight (px 54)
    , height (px 54)
    , borderStyle none
    , cursor pointer
    , hover
        [ backgroundColor lighterBlue
        ]
    , descendants
        [ selector ".material-icons"
            [ lineHeight (px 54)
            ]
        ]
    ]


container : List Mixin
container =
    [ padding2 (px 0) (pct 5)
    , maxWidth (px 1280)
    , margin2 (px 0) auto
    ]


card : List Mixin
card =
    [ backgroundColor white
    , padding (px 20)
    , cardShadow
    , marginBottom (px 15)
    ]


cardShadow : Mixin
cardShadow =
    boxShadow4 (px 1) (px 1) (px 3) (rgba 0 0 0 0.3)
