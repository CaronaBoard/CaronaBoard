module Rides.View.Instructions exposing (instructions)

import Html exposing (Html, div, li, ol, strong, text)
import Layout.Styles exposing (Classes(..), layoutClass)


instructions : Html a
instructions =
    div [ layoutClass Container ]
        [ ol []
            [ li []
                [ text "Encontre uma rota que passe perto do seu destino" ]
            , li []
                [ text "Clique no botão \"Quero Carona\"" ]
            , li []
                [ text "Preencha o pedido de carona e envie o pedido" ]
            , li []
                [ strong []
                    [ text "Pronto!" ]
                , text " Seu colega oferecendo carona para a rota selecionada irá receber sua mensagem"
                ]
            ]
        ]
