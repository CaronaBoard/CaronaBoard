module Rides.Model exposing (Model, Ride, init)

import Profile.Model exposing (Contact, Profile)


type alias Ride =
    { id : String
    , origin : String
    , destination : String
    , days : String
    , hours : String
    , profile : Profile
    }


type alias Model =
    List Ride


init : Model
init =
    []
