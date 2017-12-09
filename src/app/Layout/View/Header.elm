module Layout.View.Header exposing (header)

import Common.Icon exposing (icon)
import Common.Link exposing (linkTo)
import Html exposing (Html, a, b, button, div, h1, h2, i, img, li, nav, text, ul)
import Html.Attributes exposing (alt, href, id, rel, src, style)
import Html.Events exposing (onClick)
import Layout.Model as Layout exposing (Msg(CloseDropdown, OpenDropdown))
import Layout.Styles exposing (Classes(..), layoutClass)
import Login.Model exposing (Msg(SignOut))
import Model as Root exposing (Msg(..))
import UrlRouter.Model exposing (Msg(..))
import UrlRouter.Routes exposing (Page(..))


header : Root.Model -> Html Root.Msg
header model =
    Html.header [ layoutClass Header ] <|
        menu model.layout
            ++ [ nav [ layoutClass Navbar ]
                    [ case model.urlRouter.page of
                        GroupsListPage ->
                            div [] []

                        _ ->
                            div [ layoutClass NavBack, onClick (MsgForUrlRouter Back) ]
                                [ icon "keyboard_backspace"
                                ]
                    , ul []
                        [ case model.urlRouter.page of
                            RidesListPage groupId ->
                                li []
                                    [ linkTo (RidesCreatePage groupId)
                                        [ layoutClass AddRideLink ]
                                        [ icon "directions_car"
                                        , text "+"
                                        ]
                                    ]

                            _ ->
                                div [] []
                        , li []
                            [ a [ layoutClass MenuButton, id "openMenu", onClick (MsgForLayout OpenDropdown) ]
                                [ icon "more_vert"
                                ]
                            ]
                        ]
                    , linkTo GroupsListPage
                        [ layoutClass BrandLogo ]
                        [ b [] [ text "Carona" ]
                        , text "Board"
                        ]
                    ]
               ]


menu : Layout.Model -> List (Html Root.Msg)
menu model =
    if model.dropdownOpen then
        [ div [ layoutClass Menu, onClick (MsgForLayout CloseDropdown) ]
            [ ul [ layoutClass AnimatedDropdown ]
                [ li []
                    [ a [ layoutClass DropdownLink, href "http://goo.gl/forms/GYVDfZuhWg" ] [ text "Dar Feedback" ]
                    ]
                , li []
                    [ linkTo ProfilePage [ layoutClass DropdownLink ] [ text "Editar Perfil" ]
                    ]
                , li []
                    [ a [ layoutClass DropdownLink, onClick (MsgForLogin SignOut), layoutClass SignOutButton ] [ text "Sair" ]
                    ]
                ]
            ]
        ]
    else
        []
