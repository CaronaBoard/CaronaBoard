module Rides.Model exposing (Model, Msg(..), Ride)

import Profile.Model exposing (Contact, Profile)
import Rides.RideRequest.Model as RideRequest


type alias Ride =
    { id : String
    , userId : String
    , origin : String
    , destination : String
    , days : String
    , hours : String
    , profile : Profile
    , rideRequest : RideRequest.Model
    }


type alias Model =
    List Ride


type Msg
    = UpdateRides (List Ride)
    | MsgForRideRequest String RideRequest.Msg
