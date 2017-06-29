module Layout.Styles exposing (Classes(..), button, layoutClass, namespace, styles)

import Common.Colors exposing (..)
import Common.CssHelpers exposing (..)
import Css exposing (..)
import Css.Elements exposing (..)
import Css.Namespace
import Testable.Html exposing (Attribute)


namespace : String
namespace =
    "layout"


layoutClass : Classes -> Attribute msg
layoutClass =
    namespacedClass namespace


type Classes
    = Page
    | Menu
    | AnimatedDropdown
    | Navbar
    | BrandLogo
    | SubmitButton
    | ButtonContainer
    | OpenMenuButton
    | SignOutButton
    | AddRideLink
    | PageTitle


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
    , selector ".btn-large"
        [ important <| borderRadius (px 54)
        , important <| property "text-transform" "none"
        ]
    , class PageTitle
        [ darkTextColor
        , fontSize (px 34)
        ]
    , class SubmitButton
        button
    , class ButtonContainer
        [ displayFlex
        , justifyContent center
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
    , class AddRideLink
        [ displayFlex
        , alignItems center
        , descendants
            [ selector "i"
                [ marginRight (px 10)
                ]
            ]
        ]
    ]


layoutStyles : List Snippet
layoutStyles =
    [ class Page
        []
    , class Navbar
        [ backgroundColor primaryBlue
        ]
    , class BrandLogo
        [ fontSize (Css.rem 1.4)
        , marginLeft (px 20)
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
    , important <| backgroundColor primaryBlue -- need to overwrite materialize css default color
    , lightTextColor
    , hover
        [ backgroundColor lighterBlue
        ]
    ]
