module Rides.Styles exposing (Classes(..), className, namespace, styles)

import Common.Colors exposing (..)
import Common.CssHelpers exposing (..)
import Css exposing (..)
import Css.Elements exposing (li)
import Css.Namespace
import Html exposing (Attribute)
import Layout.Styles exposing (card)


namespace : String
namespace =
    "rides"


className : Classes -> Attribute msg
className =
    namespacedClass namespace


type Classes
    = Card
    | OtherDetails
    | ActionButton
    | Path
    | PathIcon
    | PathIconDot
    | RideInfo


styles : Stylesheet
styles =
    (stylesheet << Css.Namespace.namespace namespace)
        [ class Card <|
            card
                ++ [ descendants cardStyles
                   ]
        ]


cardStyles : List Snippet
cardStyles =
    [ selector ".material-icons"
        [ fontSize (px 16)
        , marginRight (px 5)
        , verticalAlign middle
        ]
    , class OtherDetails
        [ displayFlex
        , justifyContent spaceBetween
        , alignItems flexEnd
        , borderTop3 (px 1) solid grey
        , paddingTop (px 15)
        ]
    , class ActionButton <|
        [ important <| darkTextColor
        , important <| margin (px 0)
        , backgroundColor (hex "#EEE")
        , borderStyle none
        , padding2 (px 10) (px 15)
        , hover
            [ backgroundColor (hex "#DDD")
            ]
        ]
    , class Path
        [ marginBottom (px 10)
        ]
    , class PathIcon
        [ descendants
            [ selector ".material-icons"
                [ position absolute
                , fontSize (px 16)
                , marginTop (px 14)
                , marginLeft (px 2)
                ]
            ]
        ]
    , class PathIconDot
        [ descendants
            [ selector ".material-icons"
                [ fontSize (px 10)
                , marginLeft (px 5)
                , marginRight (px 5)
                ]
            ]
        ]
    , class RideInfo
        [ margin (px 0)
        ]
    ]
