module GiveRide.Model exposing (Model, NewRide, init)

import Common.Response exposing (Response(..))


type alias Model =
    { fields : NewRide
    , response : Response ()
    }


type alias NewRide =
    { name : String
    , origin : String
    , destination : String
    , days : String
    , hours : String
    }


init : Model
init =
    { fields =
        { name = ""
        , origin = ""
        , destination = ""
        , days = ""
        , hours = ""
        }
    , response = Empty
    }
