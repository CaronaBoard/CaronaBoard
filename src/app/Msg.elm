module Msg exposing (Msg(..))

import Login.Msg as Login
import Rides.Msg as Rides
import Router.Msg as Router


type Msg
    = MsgForRouter Router.Msg
    | MsgForLogin Login.Msg
    | MsgForRides Rides.Msg
