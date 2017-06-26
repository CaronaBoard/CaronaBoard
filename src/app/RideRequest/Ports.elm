port module RideRequest.Ports exposing (RawRideRequest, encodeRideRequest, rideRequest, subscriptions)

import Common.Response exposing (FirebaseResponse, firebaseMap)
import Login.Model exposing (User)
import RideRequest.Model exposing (RideRequest)
import RideRequest.Msg exposing (Msg(..))
import Rides.Model exposing (Contact, Ride)


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
    , contact : Contact
    }


encodeRideRequest : Ride -> User -> RideRequest -> RawRideRequest
encodeRideRequest ride user rideRequest =
    { rideId = ride.id
    , userId = user.id
    , name = rideRequest.name
    , contact = rideRequest.contact
    }
