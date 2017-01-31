module Msg exposing (Msg(..))

import Model exposing (Rider)
import Login.Msg as Login


type Msg
    = UpdateRiders (List Rider)
    | MsgForLogin Login.Msg
