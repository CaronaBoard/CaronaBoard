module Msg exposing (Msg(..))

import Model exposing (Rider)


type Msg
    = UpdateRiders (List Rider)
