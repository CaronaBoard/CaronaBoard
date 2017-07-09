port module RideRequests.Ports exposing (fetchRideRequest, fetchRideRequestResponse, subscriptions)

import Common.Response exposing (FirebaseResponse, decodeFromFirebase)
import Json.Decode as Json exposing (..)
import Json.Decode.Pipeline exposing (..)
import Profile.Ports exposing (decodeProfile)
import RideRequests.Model exposing (..)


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
        |> required "userId" string
        |> required "id" string
        |> required "profile" decodeProfile


port fetchRideRequest :
    { groupId : String
    , rideId : String
    , userId : String
    , id : String
    }
    -> Cmd msg


port fetchRideRequestResponse : (FirebaseResponse Json.Value -> msg) -> Sub msg
