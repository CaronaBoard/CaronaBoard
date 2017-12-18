module Layout.View.Header exposing (header)

import Common.Icon exposing (icon)
import Common.Link exposing (..)
import Html.Styled exposing (Html, a, b, button, div, fromUnstyled, h1, h2, i, img, li, nav, styled, text, ul)
import Html.Styled.Attributes exposing (alt, href, id, rel, src, style)
import Html.Styled.Events exposing (onClick)
import Layout.Model as Layout exposing (Msg(CloseDropdown, OpenDropdown))
import Layout.Styles exposing (..)
import Login.Model exposing (Msg(SignOut))
import Model as Root exposing (Msg(..))
import UrlRouter.Model exposing (Msg(..))
import UrlRouter.Routes exposing (Page(..))


navIcon : String -> Html a
navIcon name =
    styled div navbarMaterialIcon [] [ icon name ]


header : Root.Model -> Html Root.Msg
header model =
    styled Html.Styled.header Layout.Styles.header [] <|
        menu model.layout
            ++ [ styled nav
                    navbar
                    []
                    [ case model.urlRouter.page of
                        GroupsListPage ->
                            div [] []

                        _ ->
                            styled div
                                navBack
                                [ id "navBack", onClick (MsgForUrlRouter Back) ]
                                [ navIcon "keyboard_backspace"
                                ]
                    , ul []
                        [ case model.urlRouter.page of
                            RidesListPage groupId ->
                                li []
                                    [ styledLinkTo (RidesCreatePage groupId)
                                        addRideLink
                                        []
                                        [ navIcon "directions_car"
                                        , text "+"
                                        ]
                                    ]

                            GroupsListPage ->
                                li []
                                    [ styledLinkTo GroupsCreatePage
                                        addRideLink
                                        [ id "createGroup" ]
                                        [ navIcon "group"
                                        , text "+"
                                        ]
                                    ]

                            _ ->
                                div [] []
                        , li []
                            [ styled a
                                menuButton
                                [ id "openMenu", onClick (MsgForLayout OpenDropdown) ]
                                [ navIcon "more_vert"
                                ]
                            ]
                        ]
                    , styledLinkTo GroupsListPage
                        brandLogo
                        []
                        [ b [] [ text "Carona" ]
                        , text "Board"
                        ]
                    ]
               ]


menu : Layout.Model -> List (Html Root.Msg)
menu model =
    if model.dropdownOpen then
        [ styled div
            Layout.Styles.menu
            [ id "menu", onClick (MsgForLayout CloseDropdown) ]
            [ styled ul
                animatedDropdown
                []
                [ li []
                    [ styled a dropdownLink [ href "http://goo.gl/forms/GYVDfZuhWg" ] [ text "Dar Feedback" ]
                    ]
                , li []
                    [ styledLinkTo ProfilePage dropdownLink [] [ text "Editar Perfil" ]
                    ]
                , li []
                    [ styled a dropdownLink [ onClick (MsgForLogin SignOut), id "signOutButton" ] [ text "Sair" ]
                    ]
                ]
            ]
        ]
    else
        []
