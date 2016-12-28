module Update exposing (update)

import Model exposing (Model)
import Msg exposing (Msg(UpdateRiders))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( modelUpdate msg model, Cmd.none )


modelUpdate : Msg -> Model -> Model
modelUpdate msg model =
    case msg of
        UpdateRiders riders ->
            { riders = riders }
