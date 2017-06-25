module GiveRide.Msg exposing (Msg(..))

import Common.Response exposing (FirebaseResponse)
import Rides.Model exposing (Ride)


type Msg
    = UpdateName String
    | UpdateOrigin String
    | UpdateDestination String
    | UpdateDays String
    | UpdateHours String
    | UpdateContactType String
    | UpdateContactValue String
    | Submit
    | GiveRideResponse (FirebaseResponse Ride)


type alias Error =
    String
