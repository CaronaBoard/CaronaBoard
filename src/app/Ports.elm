port module Ports exposing (subscriptions)

import Model exposing (Model, Ride)
import Msg as Root exposing (Msg(..))
import Login.Ports as Login


subscriptions : Model -> Sub Root.Msg
subscriptions _ =
    Sub.batch
        [ rides UpdateRides
        , Sub.map MsgForLogin Login.subscriptions
        ]


port rides : (List Ride -> msg) -> Sub msg
