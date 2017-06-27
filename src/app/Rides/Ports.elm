port module Rides.Ports exposing (RawRide, decodeRide, subscriptions)

import Profile.Model exposing (Profile)
import Rides.Model exposing (Model, Ride)
import Rides.Msg exposing (Msg(..))
import Rides.RideRequest.Model as RideRequest
import Rides.RideRequest.Ports


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ rides (List.map decodeRide >> UpdateRides)
        , Rides.RideRequest.Ports.subscriptions
        ]


type alias RawRide =
    { id : String
    , origin : String
    , destination : String
    , days : String
    , hours : String
    , profile : Profile
    }


decodeRide : RawRide -> Ride
decodeRide rawRide =
    { id = rawRide.id
    , origin = rawRide.origin
    , destination = rawRide.destination
    , days = rawRide.days
    , hours = rawRide.hours
    , profile = rawRide.profile
    , rideRequest = RideRequest.init
    }


port rides : (List RawRide -> msg) -> Sub msg
