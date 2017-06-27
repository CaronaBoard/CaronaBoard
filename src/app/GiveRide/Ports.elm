port module GiveRide.Ports exposing (giveRide, subscriptions)

import Common.Response exposing (FirebaseResponse, firebaseMap)
import GiveRide.Model exposing (NewRide)
import GiveRide.Msg exposing (Msg(..))


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ giveRideResponse GiveRideResponse
        ]


port giveRide : NewRide -> Cmd msg


port giveRideResponse : (FirebaseResponse Bool -> msg) -> Sub msg
