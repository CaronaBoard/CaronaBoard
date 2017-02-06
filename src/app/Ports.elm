port module Ports exposing (subscriptions)

import Model exposing (Model, Rider)
import Msg as Root exposing (Msg(..))
import Login.Ports as Login


subscriptions : Model -> Sub Root.Msg
subscriptions _ =
    Sub.batch
        [ riders UpdateRiders
        , Sub.map MsgForLogin Login.subscriptions
        ]


port riders : (List Rider -> msg) -> Sub msg
