module Rides.Styles exposing (Classes(..), class, namespace, styles)

import Common.Colors exposing (..)
import Common.CssHelpers exposing (..)
import Css exposing (..)
import Css.Elements exposing (p)
import Css.Namespace


{ class, namespace } =
    withNamespace "rides"


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
        [ cssClass Card
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
    , cssClass CardTitle
        [ fontSize (px 16)
        , fontWeight bold
        ]
    , cssClass OtherDetails
        [ displayFlex
        , justifyContent spaceBetween
        , alignItems flexEnd
        , descendants
            [ p
                [ margin (px 0)
                ]
            ]
        ]
    , cssClass ActionButton <|
        [ darkTextColor
        , backgroundColor (hex "#EEE")
        , borderStyle none
        , padding2 (px 10) (px 15)
        , hover
            [ backgroundColor (hex "#DDD")
            ]
        ]
    , cssClass Path
        [ marginBottom (px 10)
        ]
    , cssClass PathIcon
        [ descendants
            [ selector ".material-icons"
                [ position absolute
                , fontSize (px 16)
                , marginTop (px 14)
                , marginLeft (px 2)
                ]
            ]
        ]
    , cssClass PathIconDot
        [ descendants
            [ selector ".material-icons"
                [ fontSize (px 10)
                , marginLeft (px 5)
                , marginRight (px 5)
                ]
            ]
        ]
    ]
