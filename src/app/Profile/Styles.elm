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


styles : Stylesheet
styles =
    (stylesheet << Css.Namespace.namespace namespace)
        [ class ContactField
            [ displayFlex
            , justifyContent spaceBetween
            ]
        , class ContactKind
            [ width (pct 40)
            ]
        , class ContactValue
            [ width (pct 60)
            ]
        ]
