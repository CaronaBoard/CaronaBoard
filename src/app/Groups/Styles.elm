module Groups.Styles exposing (Classes(..), className, namespace, styles)

import Common.Colors exposing (..)
import Common.CssHelpers exposing (..)
import Css exposing (..)
import Css.Elements exposing (..)
import Css.Namespace
import Html exposing (Attribute)
import Layout.Styles exposing (container)


namespace : String
namespace =
    "groups"


className : Classes -> Attribute msg
className =
    namespacedClass namespace


type Classes
    = ListContainer
    | List


styles : Stylesheet
styles =
    (stylesheet << Css.Namespace.namespace namespace)
        [ class ListContainer <|
            container
                ++ [ backgroundColor white
                   ]
        , class List
            [ listStyle none
            , backgroundColor white
            , fontSize (px 16)
            , descendants
                [ li
                    [ padding2 (px 16) (px 0)
                    , borderBottom3 (px 1) solid grey
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
