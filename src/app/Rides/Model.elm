module Rides.Model exposing (Model, Ride, init)

import Profile.Model exposing (Contact, Profile)
import Rides.RideRequest.Model as RideRequest


type alias Ride =
    { id : String
    , origin : String
    , destination : String
    , days : String
    , hours : String
    , profile : Profile
    , rideRequest : RideRequest.Model
    }


type alias Model =
    List Ride


init : Model
init =
    []
