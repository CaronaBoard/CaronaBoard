module Layout.View.Header exposing (header)

import Common.CssHelpers exposing (materializeClass)
import Common.Icon exposing (icon)
import Common.Link exposing (linkTo)
import Layout.Model exposing (Model)
import Layout.Msg exposing (Msg(CloseDropdown, OpenDropdown))
import Layout.Styles exposing (Classes(..), layoutClass)
import Login.Msg exposing (Msg(SignOut))
import Msg exposing (Msg(..))
import Testable.Html exposing (Html, a, b, button, div, h1, h2, i, img, li, nav, text, ul)
import Testable.Html.Attributes exposing (alt, href, id, rel, src, style)
import Testable.Html.Events exposing (onClick)
import UrlRouter.Routes exposing (Page(..))


header : Model -> Html Msg.Msg
header model =
    Testable.Html.header [ materializeClass "navbar-fixed" ] <|
        menu model
            ++ [ nav [ layoutClass Navbar ]
                    [ div [ materializeClass "nav-wrapper" ]
                        [ linkTo RidesPage
                            [ layoutClass BrandLogo, materializeClass "left" ]
                            [ b [] [ text "Carona" ]
                            , text "Board"
                            ]
                        , ul [ materializeClass "right" ]
                            [ li []
                                [ linkTo GiveRidePage
                                    [ layoutClass AddRideLink ]
                                    [ icon "directions_car"
                                    , text "Dou carona"
                                    ]
                                ]
                            , li []
                                [ a [ layoutClass OpenMenuButton, onClick (MsgForLayout OpenDropdown) ]
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
        [ div [ layoutClass Menu, onClick (MsgForLayout CloseDropdown) ]
            [ ul [ layoutClass AnimatedDropdown, materializeClass "dropdown-content" ]
                [ li []
                    [ a [ href "http://goo.gl/forms/GYVDfZuhWg" ] [ text "Dar Feedback" ]
                    ]
                , li []
                    [ linkTo ProfilePage [] [ text "Editar Perfil" ]
                    ]
                , li []
                    [ a [ onClick (MsgForLogin SignOut), layoutClass SignOutButton ] [ text "Sair" ]
                    ]
                ]
            ]
        ]
    else
        []
