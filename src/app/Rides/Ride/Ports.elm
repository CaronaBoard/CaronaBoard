port module Rides.Ride.Ports exposing (RideRequest, decodeRide, encodeRide, rideRequest, subscriptions)

import Common.Response exposing (FirebaseResponse, Response(..), fromFirebase)
import Json.Decode as Json exposing (..)
import Json.Decode.Pipeline exposing (..)
import Profile.Model exposing (Contact, Profile)
import Rides.Model exposing (Msg(..))
import Rides.Ride.Model as Ride exposing (Model, Msg(..))


subscriptions : Sub Rides.Model.Msg
subscriptions =
    rideRequestResponse
        (\response ->
            Rides.Model.MsgForRide response.rideId <| RideRequestResponse (fromFirebase response.response)
        )


port rideRequest : RideRequest -> Cmd msg


port rideRequestResponse : ({ rideId : String, response : FirebaseResponse Bool } -> msg) -> Sub msg


type alias RideRequest =
    { rideId : String
    , toUserId : String
    }


encodeRide : Model -> RideRequest
encodeRide ride =
    { rideId = ride.id
    , toUserId = ride.userId
    }


decodeRide : Decoder Ride.Model
decodeRide =
    decode Ride.Model
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
        |> hardcoded Empty
