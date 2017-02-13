module Msg exposing (Msg(..))

import Login.Msg as Login
import Rides.Msg as Rides


type Msg
    = MsgForRides Rides.Msg
    | MsgForLogin Login.Msg
