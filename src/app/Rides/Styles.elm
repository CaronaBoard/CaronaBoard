module Rides.Styles exposing (..)

import Common.Colors exposing (..)
import Common.CssHelpers exposing (..)
import Css exposing (..)
import Css.Foreign exposing (..)
import DEPRECATED.Css.File exposing (..)
import DEPRECATED.Css.Namespace
import Html exposing (Attribute)
import Layout.Styles


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
    | Contact


card : List Style
card =
    Layout.Styles.card ++ [ descendants cardStyles ]


contact : List Style
contact =
    [ fontSize (px 24) ]


otherDetails : List Style
otherDetails =
    [ displayFlex
    , justifyContent spaceBetween
    , alignItems flexEnd
    , borderTop3 (px 1) solid grey
    , paddingTop (px 15)
    ]


actionButton : List Style
actionButton =
    [ darkTextColor
    , margin (px 0)
    , backgroundColor (hex "#EEE")
    , borderStyle none
    , padding2 (px 10) (px 15)
    , hover
        [ backgroundColor (hex "#DDD")
        ]
    ]


path : List Style
path =
    [ marginBottom (px 10) ]


pathIcon : List Style
pathIcon =
    [ descendants
        [ selector ".layoutMaterialIcon"
            [ position absolute
            , fontSize (px 16)
            , marginTop (px 10)
            , marginLeft (px 2)
            ]
        ]
    ]


pathIconDot : List Style
pathIconDot =
    [ descendants
        [ selector ".layoutMaterialIcon"
            [ fontSize (px 10)
            , marginLeft (px 5)
            , marginRight (px 5)
            ]
        ]
    ]


rideInfo : List Style
rideInfo =
    [ margin (px 0) ]


styles : Stylesheet
styles =
    (stylesheet << DEPRECATED.Css.Namespace.namespace namespace)
        [ class Card card
        , class Contact contact
        ]


cardStyles : List Snippet
cardStyles =
    [ selector ".layoutMaterialIcon"
        [ fontSize (px 16)
        , marginRight (px 5)
        , verticalAlign middle
        ]
    , class OtherDetails otherDetails
    , class ActionButton actionButton
    , class Path path
    , class PathIcon pathIcon
    , class PathIconDot pathIconDot
    , class RideInfo rideInfo
    ]
