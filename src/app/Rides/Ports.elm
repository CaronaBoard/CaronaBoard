port module Rides.Ports exposing (subscriptions)

import Rides.Model exposing (Contact, Ride)
import Rides.Msg exposing (Msg(..))


subscriptions : Sub Msg
subscriptions =
    rides UpdateRides


port rides : (List Ride -> msg) -> Sub msg
