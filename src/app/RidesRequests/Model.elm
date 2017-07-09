module RidesRequests.Model exposing (Model, Msg(..), RideRequest)

import Common.Response exposing (Response)
import Profile.Model exposing (Profile)


type alias Model =
    Response RideRequest


type alias RideRequest =
    { groupId : String
    , rideId : String
    , toUserId : String
    , fromUserId : String
    , id : String
    , profile : Profile
    }


type Msg
    = FetchedRideRequest (Response RideRequest)
