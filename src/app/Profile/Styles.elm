module Profile.Styles exposing (Classes(..), class, namespace, styles)

import Common.CssHelpers exposing (..)
import Css exposing (..)
import Css.Namespace


{ class, namespace } =
    withNamespace "profile"


type Classes
    = ContactField
    | ContactKind
    | ContactValue
    | Select


styles : Stylesheet
styles =
    (stylesheet << Css.Namespace.namespace namespace)
        [ cssClass ContactField
            [ displayFlex
            , justifyContent spaceBetween
            ]
        , cssClass ContactKind
            [ width (pct 30)
            ]
        , cssClass ContactValue
            [ width (pct 68)
            ]
        , cssClass Select
            [ backgroundColor transparent
            , borderStyle none
            , borderBottom3 (px 1) solid (hex "#FFF")
            , marginTop (px 1)
            , display block
            , property "-webkit-appearance" "none"
            ]
        ]
