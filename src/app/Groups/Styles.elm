module Groups.Styles exposing (Classes(..), className, namespace, styles)

import Common.Colors exposing (..)
import Common.CssHelpers exposing (..)
import Css exposing (..)
import Css.Elements exposing (..)
import Css.Namespace
import Html exposing (Attribute)


namespace : String
namespace =
    "groups"


className : Classes -> Attribute msg
className =
    namespacedClass namespace


type Classes
    = List


styles : Stylesheet
styles =
    (stylesheet << Css.Namespace.namespace namespace)
        [ class List
            [ listStyle none
            , backgroundColor white
            , fontSize (px 16)
            , descendants
                [ li
                    [ padding (px 16)
                    , border3 (px 1) solid grey
                    , displayFlex
                    , alignItems center
                    , after
                        [ property "content" "\" \""
                        , display block
                        , width (px 16)
                        , height (px 16)
                        , border3 (px 1) solid darkerGrey
                        , borderBottomStyle none
                        , borderLeftStyle none
                        , transform (rotate (deg 45))
                        , marginLeft auto
                        ]
                    ]
                ]
            ]
        ]
