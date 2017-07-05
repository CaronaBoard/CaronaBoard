module Rides.Model exposing (Model, Msg(..))

import Common.Response exposing (Response)
import Rides.Ride.Model as Ride


type alias Model =
    { rides : Response (List Ride.Model)
    }


type Msg
    = UpdateRides (Response (List Ride.Model))
    | MsgForRide String Ride.Msg
