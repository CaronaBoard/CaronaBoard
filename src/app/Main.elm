port module Main exposing (..)

import Html
import Model exposing (Model, Rider, init)
import Msg exposing (Msg)
import Update exposing (update)
import View exposing (view)
import Ports exposing (subscriptions)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
