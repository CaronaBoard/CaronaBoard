port module Rides.RideRequest.Ports exposing (RideRequest, encodeRideRequest, rideRequest, subscriptions)

import Common.Response exposing (FirebaseResponse, firebaseMap)
import Rides.Model exposing (Ride)
import Rides.Msg exposing (Msg(..))
import Rides.RideRequest.Msg exposing (Msg(..))


subscriptions : Sub Rides.Msg.Msg
subscriptions =
    rideRequestResponse
        (\response ->
            MsgForRideRequest response.rideId <| RideRequestResponse response.response
        )


port rideRequest : RideRequest -> Cmd msg


port rideRequestResponse : ({ rideId : String, response : FirebaseResponse Bool } -> msg) -> Sub msg


type alias RideRequest =
    { rideId : String
    , toUserId : String
    }


encodeRideRequest : Ride -> RideRequest
encodeRideRequest ride =
    { rideId = ride.id
    , toUserId = ride.userId
    }
