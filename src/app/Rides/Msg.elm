module Rides.Msg exposing (Msg(..))

import Rides.Model exposing (Ride)
import Rides.RideRequest.Msg as RideRequest


type Msg
    = UpdateRides (List Ride)
    | MsgForRideRequest String RideRequest.Msg
