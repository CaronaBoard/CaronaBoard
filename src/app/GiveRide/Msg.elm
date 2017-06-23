module GiveRide.Msg exposing (Msg(..))


type Msg
    = UpdateName String
    | UpdateOrigin String
    | UpdateDestination String
    | UpdateDays String
    | UpdateHours String
    | Submit
