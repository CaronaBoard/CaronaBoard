port module RidesRequests.Ports exposing (fetchRideRequest, fetchRideRequestResponse, subscriptions)

import Common.Response exposing (FirebaseResponse, decodeFromFirebase)
import Json.Decode as Json exposing (..)
import Json.Decode.Pipeline exposing (..)
import Profile.Ports exposing (decodeProfile)
import RidesRequests.Model exposing (..)


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ fetchRideRequestResponse (decodeFromFirebase decodeRideRequest >> FetchedRideRequest)
        ]


decodeRideRequest : Decoder RideRequest
decodeRideRequest =
    decode RideRequest
        |> required "groupId" string
        |> required "rideId" string
        |> required "toUserId" string
        |> required "fromUserId" string
        |> required "id" string
        |> required "profile" decodeProfile


port fetchRideRequest :
    { groupId : String
    , rideId : String
    , fromUserId : String
    , id : String
    }
    -> Cmd msg


port fetchRideRequestResponse : (FirebaseResponse Json.Value -> msg) -> Sub msg
