port module Main exposing (..)

import Navigation
import Model exposing (Model, Flags, init)
import Msg exposing (Msg(MsgForRouter))
import Router.Msg exposing (Msg(UrlChange))
import Update exposing (update)
import View exposing (view)
import Ports exposing (subscriptions)
import Testable


main : Program Flags Model Msg.Msg
main =
    Navigation.programWithFlags (MsgForRouter << UrlChange)
        { init = (\navigation -> Testable.init << init navigation)
        , view = Testable.view view
        , update = Testable.update update
        , subscriptions = subscriptions
        }
