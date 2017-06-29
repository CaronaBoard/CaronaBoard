module Rides.Styles exposing (Classes(..), className, namespace, styles)

import Common.Colors exposing (..)
import Common.CssHelpers exposing (..)
import Css exposing (..)
import Css.Elements exposing (p)
import Css.Namespace
import Testable.Html exposing (Attribute)


namespace : String
namespace =
    "rides"


className : Classes -> Attribute msg
className =
    namespacedClass namespace


type Classes
    = Card
    | CardTitle
    | OtherDetails
    | ActionButton
    | Path
    | PathIcon
    | PathIconDot


styles : Stylesheet
styles =
    (stylesheet << Css.Namespace.namespace namespace)
        [ class Card
            [ display block
            , darkTextColor
            , descendants cardStyles
            ]
        ]


cardStyles : List Snippet
cardStyles =
    [ selector ".material-icons"
        [ fontSize (px 16)
        , marginRight (px 5)
        , verticalAlign middle
        ]
    , class CardTitle
        [ fontSize (px 16)
        , fontWeight bold
        ]
    , class OtherDetails
        [ displayFlex
        , justifyContent spaceBetween
        , alignItems flexEnd
        , descendants
            [ p
                [ margin (px 0)
                ]
            ]
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
    ]
