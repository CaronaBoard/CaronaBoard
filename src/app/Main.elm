port module Main exposing (..)

import Model exposing (Flags, Model, Msg(MsgForUrlRouter))
import Navigation
import Ports exposing (subscriptions)
import Testable
import Update exposing (init, update)
import UrlRouter.Model exposing (Msg(UrlChange))
import View exposing (view)


main : Program Flags Model Model.Msg
main =
    Navigation.programWithFlags (MsgForUrlRouter << UrlChange)
        { init = \navigation -> Testable.init << init navigation
        , view = Testable.view view
        , update = Testable.update update
        , subscriptions = subscriptions
        }
