module GiveRide.Model exposing (Model, init)


type alias Model =
    { name : String
    , origin : String
    , destination : String
    , days : String
    , hours : String
    }


init : Model
init =
    { name = ""
    , origin = ""
    , destination = ""
    , days = ""
    , hours = ""
    }
