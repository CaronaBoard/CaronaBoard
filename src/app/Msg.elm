module Msg exposing (Msg(..))

import Model exposing (Ride)
import Login.Msg as Login


type Msg
    = UpdateRides (List Ride)
    | MsgForLogin Login.Msg
