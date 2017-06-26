port module RideRequest.Ports exposing (encodeRideRequest, rideRequest, subscriptions)

import Common.Response exposing (FirebaseResponse, firebaseMap)
import Login.Model exposing (User)
import RideRequest.Model exposing (RideRequest)
import RideRequest.Msg exposing (Msg(..))
import Rides.Model exposing (Ride)


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ rideRequestResponse RideRequestResponse
        ]


port rideRequest : RawRideRequest -> Cmd msg


port rideRequestResponse : (FirebaseResponse Bool -> msg) -> Sub msg


type alias RawRideRequest =
    { rideId : String
    , userId : String
    , name : String
    , contactType : String
    , contactValue : String
    }


encodeRideRequest : Ride -> User -> RideRequest -> RawRideRequest
encodeRideRequest ride user newRide =
    { rideId = ride.id
    , userId = user.id
    , name = newRide.name
    , contactType = newRide.contactType
    , contactValue = newRide.contactValue
    }
