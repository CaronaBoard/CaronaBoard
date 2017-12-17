module Layout.View.Header exposing (header)

import Common.Icon exposing (icon)
import Common.Link exposing (..)
import Html.Styled exposing (Html, a, b, button, div, fromUnstyled, h1, h2, i, img, li, nav, styled, text, ul)
import Html.Styled.Attributes exposing (alt, href, id, rel, src, style)
import Html.Styled.Events exposing (onClick)
import Layout.Model as Layout exposing (Msg(CloseDropdown, OpenDropdown))
import Layout.Styles exposing (Classes(..), styledLayoutClass)
import Login.Model exposing (Msg(SignOut))
import Model as Root exposing (Msg(..))
import UrlRouter.Model exposing (Msg(..))
import UrlRouter.Routes exposing (Page(..))


header : Root.Model -> Html Root.Msg
header model =
    styled Html.Styled.header Layout.Styles.header [] <|
        menu model.layout
            ++ [ nav [ styledLayoutClass Navbar ]
                    [ case model.urlRouter.page of
                        GroupsListPage ->
                            div [] []

                        _ ->
                            div [ styledLayoutClass NavBack, onClick (MsgForUrlRouter Back) ]
                                [ fromUnstyled <| icon "keyboard_backspace"
                                ]
                    , ul []
                        [ case model.urlRouter.page of
                            RidesListPage groupId ->
                                li []
                                    [ styledLinkTo (RidesCreatePage groupId)
                                        [ styledLayoutClass AddRideLink ]
                                        [ fromUnstyled <| icon "directions_car"
                                        , text "+"
                                        ]
                                    ]

                            GroupsListPage ->
                                li []
                                    [ styledLinkTo GroupsCreatePage
                                        [ styledLayoutClass AddRideLink, id "createGroup" ]
                                        [ fromUnstyled <| icon "group"
                                        , text "+"
                                        ]
                                    ]

                            _ ->
                                div [] []
                        , li []
                            [ a [ styledLayoutClass MenuButton, id "openMenu", onClick (MsgForLayout OpenDropdown) ]
                                [ fromUnstyled <| icon "more_vert"
                                ]
                            ]
                        ]
                    , styledLinkTo GroupsListPage
                        [ styledLayoutClass BrandLogo ]
                        [ b [] [ text "Carona" ]
                        , text "Board"
                        ]
                    ]
               ]


menu : Layout.Model -> List (Html Root.Msg)
menu model =
    if model.dropdownOpen then
        [ div [ styledLayoutClass Menu, onClick (MsgForLayout CloseDropdown) ]
            [ ul [ styledLayoutClass AnimatedDropdown ]
                [ li []
                    [ a [ styledLayoutClass DropdownLink, href "http://goo.gl/forms/GYVDfZuhWg" ] [ text "Dar Feedback" ]
                    ]
                , li []
                    [ styledLinkTo ProfilePage [ styledLayoutClass DropdownLink ] [ text "Editar Perfil" ]
                    ]
                , li []
                    [ a [ styledLayoutClass DropdownLink, onClick (MsgForLogin SignOut), styledLayoutClass SignOutButton ] [ text "Sair" ]
                    ]
                ]
            ]
        ]
    else
        []
