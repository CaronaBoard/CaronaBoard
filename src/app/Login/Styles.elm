module Login.Styles exposing (styles, Classes(..), scopedId, scopedClass, scopedClassList)

import Css exposing (..)
import Css.Namespace
import Common.CssHelpers as CssHelpers


{ scopedId, scopedClass, scopedClassList, namespace } =
    CssHelpers.withNamespace "login"


type Classes
    = Page


styles : Stylesheet
styles =
    (stylesheet << Css.Namespace.namespace namespace)
        [ class Page
            [ height (pct 100)
            , width (pct 100)
            , position absolute
            , margin2 (pct 0) auto
            ]
        ]
