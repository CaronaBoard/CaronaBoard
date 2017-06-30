module Notifications.Styles exposing (Classes(..), className, namespace, styles)

import Common.Colors exposing (..)
import Common.CssHelpers exposing (..)
import Css exposing (..)
import Css.Namespace
import Html exposing (Attribute)


namespace : String
namespace =
    "notifications"


className : Classes -> Attribute msg
className =
    namespacedClass namespace


type Classes
    = NoticeVisible
    | NoticeHidden


styles : Stylesheet
styles =
    (stylesheet << Css.Namespace.namespace namespace)
        [ class NoticeVisible <|
            notice
                ++ [ bottom (px 0)
                   ]
        , class NoticeHidden <|
            notice
                ++ [ bottom (px -50)
                   ]
        ]


notice : List Mixin
notice =
    [ width (pct 100)
    , height (px 50)
    , property "transition" "all 0.5s ease"
    , lightTextColor
    , backgroundColor (rgba 0 0 0 0.8)
    , displayFlex
    , alignItems center
    , padding (px 20)
    , position fixed
    ]
