port module RidesRequests.Ports exposing (RideRequest, createRideRequest, createRideRequestResponse, encodeRideRequest, fetchRideRequest, fetchRideRequestResponse, subscriptions)

import Common.Response exposing (FirebaseResponse, decodeFromFirebase, fromFirebase)
import Json.Decode as Json exposing (..)
import Json.Decode.Pipeline exposing (..)
import Profile.Ports exposing (decodeProfile)
import Rides.Model
import RidesRequests.Model exposing (..)


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ fetchRideRequestResponse (decodeFromFirebase decodeRideRequest >> FetchedRideRequest)
        , createRideRequestResponse
            (\response ->
                CreateRideRequestResponse response.rideId (fromFirebase response.response)
            )
        ]


port fetchRideRequest :
    { groupId : String
    , rideId : String
    , fromUserId : String
    , id : String
    }
    -> Cmd msg


port fetchRideRequestResponse : (FirebaseResponse Json.Value -> msg) -> Sub msg


port createRideRequest : RideRequest -> Cmd msg


port createRideRequestResponse : ({ rideId : String, response : FirebaseResponse Bool } -> msg) -> Sub msg


type alias RideRequest =
    { groupId : String
    , rideId : String
    , toUserId : String
    }


encodeRideRequest : Rides.Model.Model -> RideRequest
encodeRideRequest ride =
    { groupId = ride.groupId
    , rideId = ride.id
    , toUserId = ride.userId
    }


decodeRideRequest : Decoder Model
decodeRideRequest =
    decode Model
        |> required "groupId" string
        |> required "rideId" string
        |> required "toUserId" string
        |> required "fromUserId" string
        |> required "id" string
        |> required "profile" decodeProfile
