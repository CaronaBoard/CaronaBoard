module Layout.View.Header exposing (header)

import Testable.Html exposing (Html, img, h1, h2, a, b, text, button, nav, div, ul, li, i)
import Testable.Html.Attributes exposing (id, href, src, rel, alt, style)
import Testable.Html.Events exposing (onClick)
import Msg exposing (Msg(MsgForLogin, MsgForLayout))
import Login.Msg exposing (Msg(SignOut))
import Common.Icon exposing (icon)
import Layout.Model exposing (Model)
import Layout.Msg exposing (Msg(OpenDropdown, CloseDropdown))
import Layout.Styles exposing (class, Classes(Navbar, BrandLogo, Menu, AnimatedDropdown, OpenMenuButton, SignOutButton))
import Common.CssHelpers exposing (materializeClass)


header : Model -> Html Msg.Msg
header model =
    Testable.Html.header [ materializeClass "navbar-fixed" ] <|
        menu model
            ++ [ nav [ class Navbar ]
                    [ div [ materializeClass "nav-wrapper" ]
                        [ a [ class BrandLogo, materializeClass "left", href "/" ]
                            [ b [] [ text "Carona" ]
                            , text "Board"
                            ]
                        , ul [ materializeClass "right" ]
                            [ li []
                                [ a [ href "http://goo.gl/forms/ohEbgkMa9i" ]
                                    [ icon "directions_car" ]
                                ]
                            , li []
                                [ a [ class OpenMenuButton, onClick (MsgForLayout OpenDropdown) ]
                                    [ icon "more_vert"
                                    ]
                                ]
                            ]
                        ]
                    ]
               ]


menu : Model -> List (Html Msg.Msg)
menu model =
    if model.dropdownOpen then
        [ div [ class Menu, onClick (MsgForLayout CloseDropdown) ]
            [ ul [ class AnimatedDropdown, materializeClass "dropdown-content" ]
                [ li []
                    [ a [ href "http://goo.gl/forms/GYVDfZuhWg" ] [ text "Dar Feedback" ]
                    ]
                , li []
                    [ a [ onClick (MsgForLogin SignOut), class SignOutButton ] [ text "Sair" ]
                    ]
                ]
            ]
        ]
    else
        []
