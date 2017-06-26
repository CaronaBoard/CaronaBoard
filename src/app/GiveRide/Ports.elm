port module GiveRide.Ports exposing (encodeNewRide, giveRide, subscriptions)

import Common.Response exposing (FirebaseResponse, firebaseMap)
import GiveRide.Model exposing (NewRide)
import GiveRide.Msg exposing (Msg(..))
import Login.Model exposing (User)


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ giveRideResponse GiveRideResponse
        ]


port giveRide : RawNewRide -> Cmd msg


port giveRideResponse : (FirebaseResponse Bool -> msg) -> Sub msg


type alias RawNewRide =
    { userId : String
    , origin : String
    , destination : String
    , days : String
    , hours : String
    }


encodeNewRide : User -> NewRide -> RawNewRide
encodeNewRide user newRide =
    { userId = user.id
    , origin = newRide.origin
    , destination = newRide.destination
    , days = newRide.days
    , hours = newRide.hours
    }
