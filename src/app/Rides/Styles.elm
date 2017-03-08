module Rides.Styles exposing (styles, Classes(..), class, namespace)

import Css exposing (..)
import Css.Elements exposing (p)
import Css.Namespace
import Common.Colors exposing (..)
import Common.CssHelpers exposing (..)


{ class, namespace } =
    withNamespace "rides"


type Classes
    = Page
    | Card
    | CardTitle
    | OtherDetails
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
        [ descendants
            [ p
                [ margin (px 0)
                ]
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
