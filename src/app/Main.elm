port module Main exposing (..)

import Model exposing (Flags, Model, Msg(MsgForUrlRouter))
import Navigation
import Ports exposing (subscriptions)
import Update exposing (init, update)
import UrlRouter.Model exposing (Msg(UrlChange))
import View exposing (view)


main : Program Flags Model Model.Msg
main =
    Navigation.programWithFlags (MsgForUrlRouter << UrlChange)
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
