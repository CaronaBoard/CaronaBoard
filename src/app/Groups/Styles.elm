module Groups.Styles exposing (..)

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


listContainer : List Style
listContainer =
    container ++ [ backgroundColor white ]


list : List Style
list =
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


joinRequests : List Style
joinRequests =
    [ marginBottom (px 30)
    ]


joinRequest : List Style
joinRequest =
    [ backgroundColor primaryBlue
    , lightTextColor
    , marginBottom (px 8)
    , displayFlex
    , alignItems center
    , justifyContent spaceBetween
    , padding2 (px 0) (px 10)
    ]


respondButton : List Style
respondButton =
    [ lightTextColor
    , padding4 (px 5) (px 15) (px 2) (px 15)
    , fontSize (px 18)
    , backgroundColor darkerBlue
    , borderStyle none
    , marginRight (px 5)
    ]


styles : Stylesheet
styles =
    (stylesheet << DEPRECATED.Css.Namespace.namespace namespace)
        [ class ListContainer listContainer
        , class List list
        , class JoinRequests joinRequests
        , class JoinRequest joinRequest
        , class RespondButton respondButton
        ]
