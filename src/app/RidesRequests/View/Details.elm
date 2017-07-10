module RidesRequests.View.Details exposing (details)

import Common.Form exposing (renderErrors)
import Common.Response as Response exposing (Response(..))
import Html exposing (..)
import Layout.Styles exposing (Classes(..), layoutClass)
import RidesRequests.Model exposing (Collection, Msg(..))
import RidesRequests.View.New exposing (contactDetails)


details : Collection -> Html msg
details collection =
    div [ layoutClass Container ]
        [ h1 [ layoutClass PageTitle ] [ text "Pedido de Carona" ]
        , div [ layoutClass Card ] <|
            case collection.list of
                Success ridesRequests ->
                    case List.head ridesRequests of
                        Just rideRequest ->
                            [ div [ layoutClass CardTitle ]
                                [ text <| "Você recebeu um pedido de carona de " ++ rideRequest.profile.name
                                ]
                            , p [] [ text "Para combinar melhor a carona, use o contato abaixo:" ]
                            , contactDetails rideRequest.profile
                            ]

                        Nothing ->
                            [ renderErrors (Error "Pedido de carona não encontrado") ]

                Error err ->
                    [ renderErrors collection.list ]

                Loading ->
                    [ text "Carregando..." ]

                Empty ->
                    [ text "Carregando..." ]
        ]
