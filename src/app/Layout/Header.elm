module Layout.Header exposing (header)

import Testable.Html exposing (Html, img, h1, h2, a, b, text, button, nav, div, ul, li, i)
import Testable.Html.Attributes exposing (id, class, href, src, rel, alt)
import Testable.Html.Events exposing (onClick)
import Msg exposing (Msg(MsgForLogin))
import Login.Msg exposing (Msg(SignOut))
import Common.Icon exposing (icon)


header : Html Msg.Msg
header =
    Testable.Html.header [ class "navbar-fixed" ]
        [ ul [ class "dropdown-content", id "nav-dropdown" ]
            [ li []
                [ a [ href "http://goo.gl/forms/GYVDfZuhWg" ] [ text "Dar Feedback" ]
                ]
            , li []
                [ a [ href "javascript:;", onClick (MsgForLogin SignOut), id "signout-button" ] [ text "Sair" ]
                ]
            ]
        , nav []
            [ div [ class "nav-wrapper" ]
                [ a [ class "brand-logo left", href "/" ]
                    [ b [] [ text "Carona" ]
                    , text "Board"
                    ]
                , ul [ class "right" ]
                    [ li []
                        [ a [ href "http://goo.gl/forms/ohEbgkMa9i" ]
                            [ icon "directions_car" ]
                        ]
                    , li []
                        [ a [ class "dropdown-button", href "javascript:;" ]
                            [ icon "more_vert"
                            ]
                        ]
                    ]
                ]
            ]
        ]
