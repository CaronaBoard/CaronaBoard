module GiveRide.Msg exposing (Msg(..))

import Common.Response exposing (FirebaseResponse)


type Msg
    = UpdateOrigin String
    | UpdateDestination String
    | UpdateDays String
    | UpdateHours String
    | Submit
    | GiveRideResponse (FirebaseResponse Bool)
