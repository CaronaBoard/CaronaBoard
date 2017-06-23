module Rides.Model exposing (Model, Ride, init)


type alias Ride =
    { id : String
    , name : String
    , origin : String
    , destination : String
    , days : String
    , hours : String
    , formUrl : String
    }


type alias Model =
    List Ride


init : Model
init =
    []
