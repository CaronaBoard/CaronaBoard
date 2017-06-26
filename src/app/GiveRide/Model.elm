module GiveRide.Model exposing (Model, NewRide, init)

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
