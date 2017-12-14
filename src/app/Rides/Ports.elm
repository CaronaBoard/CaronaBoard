port module Rides.Ports exposing (createRide, createRideResponse, decodeRides, ridesList, ridesListResponse, subscriptions)

import Common.Decoder exposing (normalizeId3)
import Common.Response exposing (..)
import Json.Decode as Json exposing (..)
import Json.Decode.Pipeline exposing (..)
import Profile.Model exposing (Contact, Profile)
import Rides.Model as Rides exposing (..)


subscriptions : Rides.Collection -> Sub Msg
subscriptions model =
    Sub.batch
        [ ridesListResponse (decodeFromFirebase decodeRides >> UpdateRides)
        , createRideResponse (fromFirebase >> CreateRideReponse)
        ]


port ridesList : () -> Cmd msg


port ridesListResponse : (FirebaseResponse Json.Value -> msg) -> Sub msg


port createRide : NewRide -> Cmd msg


port createRideResponse : (FirebaseResponse Bool -> msg) -> Sub msg


decodeRides : Decoder (List Rides.Model)
decodeRides =
    decodeRide
        |> normalizeId3 (\groupId userId id ride -> { ride | groupId = groupId, userId = userId, id = id })


decodeRide : Decoder Model
decodeRide =
    decode Model
        |> hardcoded "id"
        |> hardcoded "groupId"
        |> hardcoded "userId"
        |> required "origin" string
        |> required "destination" string
        |> required "days" string
        |> required "hours" string
        |> required "profile"
            (decode Profile
                |> required "name" string
                |> required "contact"
                    (decode Contact
                        |> required "kind" string
                        |> required "value" string
                    )
            )
