module Instructions.Instructions exposing (instructions)

import Testable.Html exposing (Html, ol, li, text, strong, div)
import Testable.Html.Attributes exposing (id)


instructions : Html a
instructions =
    div [ id "how_to" ]
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
