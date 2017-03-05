module Rides.View.Instructions exposing (instructions)

import Testable.Html exposing (Html, ol, li, text, strong, div)
import Common.CssHelpers exposing (materializeClass)


instructions : Html a
instructions =
    div [ materializeClass "container" ]
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
                , text "Seu colega oferecendo carona para a rota selecionada irá receber sua mensagem"
                ]
            ]
        ]
