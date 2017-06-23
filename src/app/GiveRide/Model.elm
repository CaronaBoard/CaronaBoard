module GiveRide.Model exposing (Model, init)

import Common.Response exposing (Response(..))


type alias Model =
    { name : String
    , origin : String
    , destination : String
    , days : String
    , hours : String
    , response : Response ()
    }


init : Model
init =
    { name = ""
    , origin = ""
    , destination = ""
    , days = ""
    , hours = ""
    , response = Empty
    }
