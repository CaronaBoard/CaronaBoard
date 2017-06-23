port module GiveRide.Ports exposing (giveRide, subscriptions)

import Common.Response exposing (FirebaseResponse)
import GiveRide.Msg exposing (Msg(..))
import Rides.Model exposing (Ride)


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ giveRideResponse GiveRideResponse
        ]


port giveRide :
    { userId : String
    , name : String
    , origin : String
    , destination : String
    , days : String
    , hours : String
    }
    -> Cmd msg


port giveRideResponse : (FirebaseResponse Ride -> msg) -> Sub msg
