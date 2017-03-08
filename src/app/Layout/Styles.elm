module Layout.Styles exposing (styles, Classes(..), class, namespace)

import Css exposing (..)
import Css.Elements exposing (..)
import Css.Namespace
import Common.CssHelpers exposing (..)
import Common.Colors exposing (..)


{ class, namespace } =
    withNamespace "layout"


type Classes
    = Menu
    | AnimatedDropdown
    | Navbar
    | BrandLogo
    | ButtonContainer


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
    , cssClass ButtonContainer
        [ displayFlex
        , justifyContent center
        ]
    , selector ".input-field"
        [ descendants
            [ selector "label"
                [ important <| top (px -10)
                , important <| fontSize (pct 80)
                ]
            , selector "input:placeholder-shown:not(:focus) + *"
                [ important <| fontSize (pct 100)
                , important <| top (px 10)
                ]
            ]
        ]
    ]


layoutStyles : List Snippet
layoutStyles =
    [ cssClass Navbar
        [ backgroundColor primaryBlue
        ]
    , cssClass BrandLogo
        [ fontSize (Css.rem 1.4)
        , marginLeft (px 10)
        ]
    , cssClass Menu
        [ position fixed
        , width (pct 100)
        , height (pct 100)
        , zIndex (int 998)
        , children
            [ cssClass AnimatedDropdown
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
                [ maxHeight (px 100)
                , opacity (int 1)
                , property "} /*" "*/"
                ]
            ]
        ]
    ]
