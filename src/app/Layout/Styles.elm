module Layout.Styles exposing (Classes(..), button, class, namespace, styles)

import Common.Colors exposing (..)
import Common.CssHelpers exposing (..)
import Css exposing (..)
import Css.Elements exposing (..)
import Css.Namespace


{ class, namespace } =
    withNamespace "layout"


type Classes
    = Page
    | Menu
    | AnimatedDropdown
    | Navbar
    | BrandLogo
    | SubmitButton
    | ButtonContainer
    | OpenMenuButton
    | SignOutButton
    | AddRideLink
    | PageTitle
    | NotificationVisible
    | NotificationHidden


styles : Stylesheet
styles =
    (stylesheet << Css.Namespace.namespace namespace)
        (generalStyles ++ layoutStyles)


generalStyles : List Snippet
generalStyles =
    [ html
        [ fontFamilies [ "Lato", sansSerif.value ]
        ]
    , body
        [ backgroundColor grey
        ]
    , selector ".btn-large"
        [ important <| borderRadius (px 54)
        , important <| property "text-transform" "none"
        ]
    , cssClass PageTitle
        [ darkTextColor
        , fontSize (px 34)
        ]
    , cssClass SubmitButton
        button
    , cssClass ButtonContainer
        [ displayFlex
        , justifyContent center
        ]
    , selector ".input-field"
        [ descendants
            [ selector "label"
                [ important <| top (px -10)
                , important <| fontSize (pct 80)
                ]
            , selector "input"
                [ important <| fontSize (Css.rem 1.1)
                ]
            , selector "input:placeholder-shown:not(:focus) + *"
                [ important <| fontSize (Css.rem 1.1)
                , important <| top (px 10)
                ]
            ]
        ]
    , cssClass AddRideLink
        [ displayFlex
        , alignItems center
        , descendants
            [ selector "i"
                [ marginRight (px 10)
                ]
            ]
        ]
    ]


layoutStyles : List Snippet
layoutStyles =
    [ cssClass Page
        []
    , cssClass Navbar
        [ backgroundColor primaryBlue
        ]
    , cssClass BrandLogo
        [ fontSize (Css.rem 1.4)
        , marginLeft (px 20)
        ]
    , cssClass Menu
        [ position fixed
        , width (pct 100)
        , height (pct 100)
        , zIndex (int 998)
        , children
            [ cssClass AnimatedDropdown
                [ margin (px 10)
                , display block
                , top (px 0)
                , right (px 0)
                , width auto
                , opacity (int 1)
                , overflow hidden
                , property "animation" "slideDown 0.3s"
                ]
            ]
        ]
    , cssClass NotificationVisible <|
        notification
            ++ [ bottom (px 0)
               ]
    , cssClass NotificationHidden <|
        notification
            ++ [ bottom (px -50)
               ]

    -- TODO: This below is a very hacky way of adding keyframes, waiting for elm-css to add support for it
    , selector "@keyframes slideDown {"
        [ descendants
            [ selector "from"
                [ maxHeight (px 0)
                , opacity (int 0)
                , property "} /*" ""
                ]
            , selector "*/ to"
                [ maxHeight (px 100)
                , opacity (int 1)
                , property "} /*" "*/"
                ]
            ]
        ]
    ]


button : List Mixin
button =
    [ width (pct 100)
    , important <| backgroundColor primaryBlue -- need to overwrite materialize css default color
    , lightTextColor
    , hover
        [ backgroundColor lighterBlue
        ]
    ]


notification : List Mixin
notification =
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
