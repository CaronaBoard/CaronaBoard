port module RideRequest.Ports exposing (RideRequest, encodeRideRequest, rideRequest, subscriptions)

import Common.Response exposing (FirebaseResponse, firebaseMap)
import RideRequest.Msg exposing (Msg(..))
import Rides.Model exposing (Ride)


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ rideRequestResponse RideRequestResponse
        ]


port rideRequest : RideRequest -> Cmd msg


port rideRequestResponse : (FirebaseResponse Bool -> msg) -> Sub msg


type alias RideRequest =
    { rideId : String
    }


encodeRideRequest : Ride -> RideRequest
encodeRideRequest ride =
    { rideId = ride.id
    }
