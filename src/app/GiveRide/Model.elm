module GiveRide.Model exposing (Model, Msg(..), NewRide)

import Common.Response exposing (Response(..))


type alias Model =
    { fields : NewRide
    , response : Response Bool
    }


type alias NewRide =
    { origin : String
    , destination : String
    , days : String
    , hours : String
    }


type Msg
    = UpdateOrigin String
    | UpdateDestination String
    | UpdateDays String
    | UpdateHours String
    | Submit
    | GiveRideResponse (Response Bool)
