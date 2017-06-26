module RideRequest.Msg exposing (Msg(..))

import Common.Response exposing (FirebaseResponse)
import Rides.Model exposing (Ride)


type Msg
    = UpdateName String
    | UpdateContactType String
    | UpdateContactValue String
    | Submit Ride
    | RideRequestResponse (FirebaseResponse Bool)
