module Layout.Styles exposing (styles, Classes(..), scopedId, scopedClass, scopedClassList)

import Css exposing (..)
import Css.Namespace
import Common.CssHelpers as CssHelpers


{ scopedId, scopedClass, scopedClassList, namespace } =
    CssHelpers.withNamespace "layout"


type Classes
    = Menu
    | AnimatedDropdown


styles : Stylesheet
styles =
    (stylesheet << Css.Namespace.namespace namespace)
        [ class Menu
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
                    [ maxHeight (px 100)
                    , opacity (int 1)
                    , property "} /*" "*/"
                    ]
                ]
            ]
        ]
