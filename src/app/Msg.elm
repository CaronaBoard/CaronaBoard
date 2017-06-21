module Msg exposing (Msg(..))

import Layout.Msg as Layout
import Login.Msg as Login
import Rides.Msg as Rides
import UrlRouter.Msg as UrlRouter


type Msg
    = MsgForUrlRouter UrlRouter.Msg
    | MsgForLogin Login.Msg
    | MsgForRides Rides.Msg
    | MsgForLayout Layout.Msg
