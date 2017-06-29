module Rides.Model exposing (Model, Msg(..))

import Rides.Ride.Model as Ride


type alias Model =
    List Ride.Model


type Msg
    = UpdateRides (List Ride.Model)
    | MsgForRide String Ride.Msg
