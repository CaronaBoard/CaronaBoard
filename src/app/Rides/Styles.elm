module Rides.Styles exposing (styles, Classes(..), scopedId, scopedClass, scopedClassList)

import Css exposing (..)
import Css.Elements exposing (p)
import Common.Colors exposing (..)
import Css.Namespace
import Common.CssHelpers as CssHelpers


{ scopedId, scopedClass, scopedClassList, namespace } =
    CssHelpers.withNamespace "rides"


type Classes
    = Card
    | CardTitle
    | OtherDetails
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
        [ descendants
            [ p
                [ margin (px 0)
                ]
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
