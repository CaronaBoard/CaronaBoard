module Rides.Update exposing (update)

import Rides.Model exposing (Model)
import Rides.Msg exposing (Msg(..))


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateRides rides ->
            rides
