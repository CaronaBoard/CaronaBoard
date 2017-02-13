module Rides.Model exposing (Model, Ride, init)


type alias Ride =
    { id : String
    , name : String
    , origin : String
    , destination : String
    , area : String
    , days : String
    , hours : String
    , flexible : Bool
    , formUrl : String
    }


type alias Model =
    List Ride


init : Model
init =
    []
