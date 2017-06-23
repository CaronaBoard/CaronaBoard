module Rides.Update exposing (update)

import Msg as Root exposing (Msg(..))
import Rides.Model exposing (Model)
import Rides.Msg exposing (Msg(UpdateRides))
import Testable.Cmd


update : Root.Msg -> Model -> ( Model, Testable.Cmd.Cmd Rides.Msg.Msg )
update msg model =
    case msg of
        MsgForRides (UpdateRides rides) ->
            ( rides, Testable.Cmd.none )

        _ ->
            ( model, Testable.Cmd.none )
