port module Rides.RideRequest.Ports exposing (RideRequest, encodeRideRequest, rideRequest, subscriptions)

import Common.Response exposing (FirebaseResponse, fromFirebase)
import Rides.Model exposing (Msg(..), Ride)
import Rides.RideRequest.Model exposing (Msg(..))


subscriptions : Sub Rides.Model.Msg
subscriptions =
    rideRequestResponse
        (\response ->
            MsgForRideRequest response.rideId <| RideRequestResponse (fromFirebase response.response)
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
