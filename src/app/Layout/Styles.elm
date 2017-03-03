module Layout.Styles exposing (styles, Ids(..), scopedId, scopedClass, scopedClassList)

import Css exposing (..)
import Css.Namespace
import Common.CssHelpers as CssHelpers


{ scopedId, scopedClass, scopedClassList, namespace } =
    CssHelpers.withNamespace "layout"


type Ids
    = Menu


styles : Stylesheet
styles =
    (stylesheet << Css.Namespace.namespace namespace)
        [ id Menu
            [ position fixed
            , width (pct 100)
            , height (pct 100)
            , zIndex (int 998)
            ]
        ]
