module Update exposing (update)

import Model exposing (Model)
import Login.Update as Login
import Msg exposing (Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( modelUpdate msg model, cmdUpdate msg model )


modelUpdate : Msg -> Model -> Model
modelUpdate msg model =
    case msg of
        UpdateRiders riders ->
            { model | riders = riders }

        MsgForLogin loginMsg ->
            { model | login = Login.update loginMsg model.login }


cmdUpdate : Msg -> Model -> Cmd Msg
cmdUpdate msg model =
    case msg of
        UpdateRiders riders ->
            Cmd.none

        MsgForLogin loginMsg ->
            Cmd.map MsgForLogin <| Login.cmdUpdate loginMsg model.login
