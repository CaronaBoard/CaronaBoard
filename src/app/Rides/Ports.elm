port module Rides.Ports exposing (decodeRide, subscriptions)

import Common.Decoder exposing (normalizeId2)
import Json.Decode as Json exposing (..)
import Json.Decode.Pipeline exposing (..)
import Profile.Model exposing (Contact, Profile)
import Rides.Model exposing (Model, Ride)
import Rides.Model exposing (Msg(..))
import Rides.RideRequest.Model as RideRequest
import Rides.RideRequest.Ports


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ rides (decodeValue decodeRide >> Result.withDefault [] >> UpdateRides)
        , Rides.RideRequest.Ports.subscriptions
        ]


decodeRide : Decoder (List Ride)
decodeRide =
    normalizeId2
        (\userId id ride -> { ride | userId = userId, id = id })
        (decode Ride
            |> hardcoded "id"
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
            |> hardcoded RideRequest.init
        )


port rides : (Json.Value -> msg) -> Sub msg
