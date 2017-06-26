module Profile.Styles exposing (Classes(..), class, namespace, styles)

import Common.CssHelpers exposing (..)
import Css exposing (..)
import Css.Namespace


{ class, namespace } =
    withNamespace "profile"


type Classes
    = ContactField


styles : Stylesheet
styles =
    (stylesheet << Css.Namespace.namespace namespace)
        [ cssClass ContactField
            [ displayFlex
            , justifyContent spaceBetween
            ]
        ]
