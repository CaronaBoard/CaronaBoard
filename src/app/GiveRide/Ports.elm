port module GiveRide.Ports exposing (giveRide, subscriptions)

import Common.Response exposing (FirebaseResponse, fromFirebase)
import GiveRide.Model exposing (Msg(..), NewRide)


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ giveRideResponse (fromFirebase >> GiveRideResponse)
        ]


port giveRide : NewRide -> Cmd msg


port giveRideResponse : (FirebaseResponse Bool -> msg) -> Sub msg
