module Groups.Styles exposing (Classes(..), className, namespace, styles)

import Common.Colors exposing (..)
import Common.CssHelpers exposing (..)
import Css exposing (..)
import Css.Foreign exposing (..)
import DEPRECATED.Css.File exposing (..)
import DEPRECATED.Css.Namespace
import Html exposing (Attribute)
import Layout.Styles exposing (card, container)


namespace : String
namespace =
    "groups"


className : Classes -> Attribute msg
className =
    namespacedClass namespace


type Classes
    = ListContainer
    | List
    | JoinRequests
    | JoinRequest
    | RespondButton


styles : Stylesheet
styles =
    (stylesheet << DEPRECATED.Css.Namespace.namespace namespace)
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
        , class JoinRequests <|
            [ marginBottom (px 30)
            ]
        , class JoinRequest <|
            [ backgroundColor primaryBlue
            , lightTextColor
            , marginBottom (px 8)
            , displayFlex
            , alignItems center
            , justifyContent spaceBetween
            , padding2 (px 0) (px 10)
            ]
        , class RespondButton <|
            [ lightTextColor
            , padding4 (px 5) (px 15) (px 2) (px 15)
            , fontSize (px 18)
            , backgroundColor darkerBlue
            , borderStyle none
            , marginRight (px 5)
            ]
        ]
