module GiveRide.Model exposing (Model, Msg(..), NewRide, init)

import Common.Response exposing (FirebaseResponse, Response(..))


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
    | GiveRideResponse (FirebaseResponse Bool)


init : Model
init =
    { fields =
        { origin = ""
        , destination = ""
        , days = ""
        , hours = ""
        }
    , response = Empty
    }
