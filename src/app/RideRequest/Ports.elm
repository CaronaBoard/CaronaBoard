port module RideRequest.Ports exposing (RideRequest, encodeRideRequest, rideRequest, subscriptions)

import Common.Response exposing (FirebaseResponse, firebaseMap)
import Login.Model exposing (User)
import RideRequest.Msg exposing (Msg(..))
import Rides.Model exposing (Contact, Ride)


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ rideRequestResponse RideRequestResponse
        ]


port rideRequest : RideRequest -> Cmd msg


port rideRequestResponse : (FirebaseResponse Bool -> msg) -> Sub msg


type alias RideRequest =
    { rideId : String
    , userId : String
    }


encodeRideRequest : Ride -> User -> RideRequest
encodeRideRequest ride user =
    { rideId = ride.id
    , userId = user.id
    }
