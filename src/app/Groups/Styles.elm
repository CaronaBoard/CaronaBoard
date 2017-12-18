module Groups.Styles exposing (..)

import Common.Colors exposing (..)
import Common.CssHelpers exposing (StyledElement)
import Css exposing (..)
import Css.Foreign as Foreign
import Html.Styled exposing (..)
import Layout.Styles exposing (card, container)


listContainer : StyledElement msg
listContainer =
    styled div
        (container ++ [ backgroundColor white ])


list : StyledElement msg
list =
    styled ul
        [ listStyle none
        , backgroundColor white
        , fontSize (px 16)
        , Foreign.descendants
            [ Foreign.li
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


joinRequests : StyledElement msg
joinRequests =
    styled ul
        [ marginBottom (px 30)
        ]


joinRequest : StyledElement msg
joinRequest =
    styled li
        [ backgroundColor primaryBlue
        , lightTextColor
        , marginBottom (px 8)
        , displayFlex
        , alignItems center
        , justifyContent spaceBetween
        , padding2 (px 0) (px 10)
        ]


respondButton : StyledElement msg
respondButton =
    styled button
        [ lightTextColor
        , padding4 (px 5) (px 15) (px 2) (px 15)
        , fontSize (px 18)
        , backgroundColor darkerBlue
        , borderStyle none
        , marginRight (px 5)
        ]
