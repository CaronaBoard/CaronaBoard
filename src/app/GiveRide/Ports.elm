port module GiveRide.Ports exposing (giveRide, subscriptions)

import Common.Response exposing (FirebaseResponse, firebaseMap)
import GiveRide.Model exposing (Msg(..), NewRide)


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ giveRideResponse GiveRideResponse
        ]


port giveRide : NewRide -> Cmd msg


port giveRideResponse : (FirebaseResponse Bool -> msg) -> Sub msg
