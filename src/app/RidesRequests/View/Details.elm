module RidesRequests.View.Details exposing (details)

import Common.Form exposing (renderErrors)
import Html.Styled exposing (..)
import Layout.Styles exposing (..)
import RemoteData exposing (..)
import RidesRequests.Model exposing (Collection, Msg(..))
import RidesRequests.View.New exposing (contactDetails)


details : Collection -> Html msg
details collection =
    styled div
        container
        []
        [ styled h1 pageTitle [] [ text "Pedido de Carona" ]
        , styled div card [] <|
            case collection.list of
                Success ridesRequests ->
                    case List.head ridesRequests of
                        Just rideRequest ->
                            [ styled div
                                cardTitle
                                []
                                [ text <| "Você recebeu um pedido de carona de " ++ rideRequest.profile.name
                                ]
                            , p [] [ text "Para combinar melhor a carona, use o contato abaixo:" ]
                            , contactDetails rideRequest.profile
                            ]

                        Nothing ->
                            [ renderErrors (Failure "Pedido de carona não encontrado") ]

                Failure err ->
                    [ renderErrors collection.list ]

                Loading ->
                    [ text "Carregando..." ]

                NotAsked ->
                    [ text "Carregando..." ]
        ]
