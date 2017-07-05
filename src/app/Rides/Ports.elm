port module Rides.Ports exposing (decodeRides, ridesList, ridesListResponse, subscriptions)

import Common.Decoder exposing (normalizeId3)
import Common.Response exposing (FirebaseResponse, decodeFromFirebase)
import Json.Decode as Json exposing (..)
import Rides.Model exposing (Model, Msg(..))
import Rides.Ride.Model as Ride
import Rides.Ride.Ports exposing (decodeRide)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ ridesListResponse (decodeFromFirebase decodeRides >> UpdateRides)
        , Rides.Ride.Ports.subscriptions
        ]


decodeRides : Decoder (List Ride.Model)
decodeRides =
    decodeRide
        |> normalizeId3 (\groupId userId id ride -> { ride | groupId = groupId, userId = userId, id = id })


port ridesList : () -> Cmd msg


port ridesListResponse : (FirebaseResponse Json.Value -> msg) -> Sub msg
