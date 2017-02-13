module Rides.Msg exposing (Msg(..))

import Rides.Model exposing (Ride)


type Msg
    = UpdateRides (List Ride)
