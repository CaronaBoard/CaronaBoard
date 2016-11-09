port module Main exposing (..)

import Html.App as App
import Model exposing (Model, Rider)
import Msg exposing (Msg(UpdateRiders))
import Update exposing (update)
import Layout.Home exposing (view)
import Ports exposing (subscriptions)


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    ( { riders = [] }, Cmd.none )
