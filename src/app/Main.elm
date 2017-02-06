port module Main exposing (..)

import Testable.Html as Html
import Model exposing (Model, Flags, init)
import Msg exposing (Msg)
import Update exposing (update)
import View exposing (view)
import Ports exposing (subscriptions)
import Testable


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { init = Testable.init << init
        , view = Testable.view view
        , update = Testable.update update
        , subscriptions = subscriptions
        }
