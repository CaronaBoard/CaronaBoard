module Layout.Header exposing (header)

import Testable.Html exposing (Html, div, img, h1, h2, a, text, button)
import Testable.Html.Attributes exposing (id, href, src, rel, alt)
import Testable.Html.Events exposing (onClick)
import Msg exposing (Msg(MsgForLogin))
import Login.Msg exposing (Msg(SignOut))


header : Html Msg.Msg
header =
    div [ id "header" ]
        [ div [ id "topbar" ]
            [ div [ id "title" ]
                [ img [ id "title_img", src "images/logo.svg", alt "Logo Carona Board" ]
                    []
                , h1 []
                    [ text "Carona Board" ]
                , h2 []
                    [ text "Seu carro não precisa levar apenas você" ]
                ]
            , div [ id "main_menu" ]
                [ div [ id "button_offer" ]
                    [ a [ href "http://goo.gl/forms/ohEbgkMa9i", rel "noopener" ]
                        [ text "DOU CARONA!" ]
                    ]
                ]
            ]
        , button [ id "signout-button", onClick (MsgForLogin SignOut) ] [ text "Sair" ]
        ]
