port module Main exposing (..)

import Html.App as App
import Model exposing (Model, Rider, init)
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
