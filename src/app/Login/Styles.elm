module Login.Styles exposing (styles, Classes(..), scopedId, scopedClass, scopedClassList)

import Css exposing (..)
import Css.Elements exposing (..)
import Common.Colors exposing (..)
import Css.Namespace
import Common.CssHelpers as CssHelpers


{ scopedId, scopedClass, scopedClassList, namespace } =
    CssHelpers.withNamespace "login"


type Classes
    = Page
    | Button
    | SubmitButton


styles : Stylesheet
styles =
    (stylesheet << Css.Namespace.namespace namespace)
        [ class Page
            [ height (pct 100)
            , width (pct 100)
            , position absolute
            , margin2 (pct 0) auto
            , descendants
                [ h1
                    [ fontSize (px 32)
                    ]
                , input
                    [ important <| borderBottom3 (px 1) solid white
                    ]
                , label
                    [ important <| color white
                    ]
                , class Button
                    [ width (pct 100)
                    , color white
                    ]
                , class SubmitButton
                    [ color primaryBlue
                    , backgroundColor white
                    , hover
                        [ backgroundColor grey
                        ]
                    ]
                ]
            ]
        ]