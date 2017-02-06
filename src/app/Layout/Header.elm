module Layout.Header exposing (header)

import Testable.Html exposing (Html, div, img, h1, h2, a, text)
import Testable.Html.Attributes exposing (id, href, src, rel, alt)


header : Html a
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
        ]
