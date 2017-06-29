module Rides.Ride.Model exposing (Model, Msg(..))

import Common.Response exposing (Response(..))
import Profile.Model exposing (Profile)


type alias Model =
    { id : String
    , userId : String
    , origin : String
    , destination : String
    , days : String
    , hours : String
    , profile : Profile
    , rideRequest : Response Bool
    }


type Msg
    = Submit
    | RideRequestResponse (Response Bool)
