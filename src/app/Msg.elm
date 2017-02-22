module Msg exposing (Msg(..))

import Login.Msg as Login
import Rides.Msg as Rides
import UrlRouter.Msg as UrlRouter
import Layout.Msg as Layout


type Msg
    = MsgForUrlRouter UrlRouter.Msg
    | MsgForLogin Login.Msg
    | MsgForRides Rides.Msg
    | MsgForLayout Layout.Msg
