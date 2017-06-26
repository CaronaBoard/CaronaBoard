module Rides.Model exposing (Model, Ride, init)

import Profile.Model exposing (Contact)


type alias Ride =
    { id : String
    , name : String
    , origin : String
    , destination : String
    , days : String
    , hours : String
    , contact : Contact
    }


type alias Model =
    List Ride


init : Model
init =
    []
