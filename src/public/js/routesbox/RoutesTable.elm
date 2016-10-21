module RoutesTable exposing (..)

import Html exposing (Html, text, table, thead, tbody, tr, th, td, ol, li, a, div, strong, p)
import Html.App as App
import Html.Attributes exposing (id, class, href, target)


main : Program Never
main =
    App.beginnerProgram { model = Nothing, view = view, update = \_ _ -> Nothing }

view : a -> Html a
view model =
    table []
    [ thead []
        [ tr []
            [ th []
                [ text "Rota" ]
            , th []
                [ text "Trajeto" ]
            , th []
                [ text "Quando" ]
            , th []
                [ text "Horário" ]
            , th []
                [ text "Motorista" ]
            , th []
                []
            ]
        ]
    , tbody []
        [ tr []
            [ td []
                [ strong []
                    [ text "Aeroporto" ]
                ]
            , td []
                [ ol []
                    [ li []
                        [ text "Origem: Tecnopuc" ]
                    , li []
                        [ text "Destino: Estação Trensurb Bairro Anchieta" ]
                    ]
                , p [ class "depende" ]
                    [ text "(*)Rota flexível? falar c/ motorista" ]
                ]
            , td []
                [ text "Seg a Sex" ]
            , td []
                [ text "19:00" ]
            , td []
                [ text "Fulana Silva" ]
            , td []
                [ div [ id "button_carona" ]
                    [ a [ href "http://goo.gl/forms/R5f1MI6WV2", target "_blank" ]
                        [ text "QUERO CARONA" ]
                    ]
                ]
            ]
        ]
    ]
