module RidesRequests.View.Details exposing (details)

import Common.Response as Response exposing (Response(..))
import Html exposing (..)
import Layout.Styles exposing (Classes(..), layoutClass)
import Rides.Ride.View exposing (contactDetails)
import RidesRequests.Model exposing (Model, Msg(..))


details : Model -> Html msg
details model =
    case model of
        Success rideRequest ->
            div [ layoutClass Container ]
                [ h1 [ layoutClass PageTitle ] [ text "Pedido de Carona" ]
                , div [ layoutClass Card ]
                    [ div [ layoutClass CardTitle ]
                        [ text <| "Você recebeu um pedido de carona de " ++ rideRequest.profile.name
                        ]
                    , p [] [ text "Para combinar melhor a carona, use o contato abaixo:" ]
                    , contactDetails rideRequest.profile
                    ]
                ]

        _ ->
            text ""
