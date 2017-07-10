module Rides.Model exposing (Collection, Model, Msg(..))

import Common.Response exposing (Response)
import Profile.Model exposing (Profile)


type alias Collection =
    { list : Response (List Model)
    }


type alias Model =
    { id : String
    , groupId : String
    , userId : String
    , origin : String
    , destination : String
    , days : String
    , hours : String
    , profile : Profile
    , rideRequest : Response Bool
    }


type Msg
    = UpdateRides (Response (List Model))
    | Submit RideId GroupId
    | RideRequestResponse RideId (Response Bool)


type alias RideId =
    String


type alias GroupId =
    String
