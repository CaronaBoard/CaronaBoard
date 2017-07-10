module Rides.Model exposing (Collection, Model, Msg(..), NewRide)

import Common.Response exposing (Response)
import Profile.Model exposing (Profile)


type alias Collection =
    { list : Response (List Model)
    , new :
        { fields : NewRide
        , response : Response Bool
        }
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
    }


type alias NewRide =
    { groupId : String
    , origin : String
    , destination : String
    , days : String
    , hours : String
    }


type Msg
    = UpdateRides (Response (List Model))
    | UpdateOrigin String
    | UpdateDestination String
    | UpdateDays String
    | UpdateHours String
    | CreateRide GroupId
    | CreateRideReponse (Response Bool)


type alias GroupId =
    String
