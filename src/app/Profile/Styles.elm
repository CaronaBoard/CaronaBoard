module Profile.Styles exposing (Classes(..), className, namespace, styles)

import Common.CssHelpers exposing (..)
import Css exposing (..)
import Css.Namespace
import Html exposing (Attribute)


namespace : String
namespace =
    "profile"


className : Classes -> Attribute msg
className =
    namespacedClass namespace


type Classes
    = ContactField
    | ContactKind
    | ContactValue
    | Select


styles : Stylesheet
styles =
    (stylesheet << Css.Namespace.namespace namespace)
        [ class ContactField
            [ displayFlex
            , justifyContent spaceBetween
            ]
        , class ContactKind
            [ width (pct 30)
            ]
        , class ContactValue
            [ width (pct 68)
            ]
        , class Select
            [ backgroundColor transparent
            , borderStyle none
            , borderBottom3 (px 1) solid (hex "#FFF")
            , marginTop (px 1)
            , display block
            , property "-webkit-appearance" "none"
            ]
        ]
