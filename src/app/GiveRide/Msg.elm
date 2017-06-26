module GiveRide.Msg exposing (Msg(..))

import Common.Response exposing (FirebaseResponse)


type Msg
    = UpdateName String
    | UpdateOrigin String
    | UpdateDestination String
    | UpdateDays String
    | UpdateHours String
    | UpdateContactType String
    | UpdateContactValue String
    | Submit
    | GiveRideResponse (FirebaseResponse Bool)
