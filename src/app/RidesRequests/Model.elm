module RidesRequests.Model exposing (Collection, Model, Msg(..))

import Common.Response exposing (Response)
import Profile.Model exposing (Profile)
import Rides.Model


type alias Collection =
    { list : Response (List Model)
    , new :
        { response : Response Bool
        }
    }


type alias Model =
    { groupId : String
    , rideId : String
    , toUserId : String
    , fromUserId : String
    , id : String
    , profile : Profile
    }


type Msg
    = FetchedRideRequest (Response Model)
    | CreateRideRequest Rides.Model.Model
    | CreateRideRequestResponse RideId (Response Bool)


type alias RideId =
    String


type alias GroupId =
    String
