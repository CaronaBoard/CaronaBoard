port module Main exposing (..)

import Html.Styled exposing (toUnstyled)
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
        , view = view >> toUnstyled
        , update = update
        , subscriptions = subscriptions
        }
