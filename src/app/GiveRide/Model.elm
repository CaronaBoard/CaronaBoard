module GiveRide.Model exposing (Model, NewRide, init)

import Common.Response exposing (Response(..))
import Rides.Model exposing (Contact(..), Ride)


type alias Model =
    { fields : NewRide
    , response : Response Ride
    }


type alias NewRide =
    { name : String
    , origin : String
    , destination : String
    , days : String
    , hours : String
    , contactType : String
    , contactValue : String
    }


init : Model
init =
    { fields =
        { name = ""
        , origin = ""
        , destination = ""
        , days = ""
        , hours = ""
        , contactType = "Whatsapp"
        , contactValue = ""
        }
    , response = Empty
    }
