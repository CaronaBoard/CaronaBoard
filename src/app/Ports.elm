port module Ports exposing (subscriptions)

import Model exposing (Model, Rider)
import Msg exposing (Msg(UpdateRiders))


subscriptions : Model -> Sub Msg
subscriptions model =
    riders UpdateRiders


port riders : (List Rider -> msg) -> Sub msg
