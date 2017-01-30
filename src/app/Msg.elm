module Msg exposing (Msg(..))

import Model exposing (Rider)
import Login.Update as Login


type Msg
    = UpdateRiders (List Rider)
    | UpdateLogin (Login.Msg)
