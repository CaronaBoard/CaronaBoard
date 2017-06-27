module Rides.RideRequest.Msg exposing (Msg(..))

import Common.Response exposing (FirebaseResponse)
import Rides.Model exposing (Ride)


type Msg
    = Submit Ride
    | RideRequestResponse (FirebaseResponse Bool)
