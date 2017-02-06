module Update exposing (update)

import Model exposing (Model)
import Login.Update as Login
import Msg exposing (Msg(..))
import Testable.Cmd


update : Msg -> Model -> ( Model, Testable.Cmd.Cmd Msg )
update msg model =
    ( modelUpdate msg model, cmdUpdate msg model )


modelUpdate : Msg -> Model -> Model
modelUpdate msg model =
    case msg of
        UpdateRiders riders ->
            { model | riders = riders }

        MsgForLogin loginMsg ->
            { model | login = Login.update loginMsg model.login }


cmdUpdate : Msg -> Model -> Testable.Cmd.Cmd Msg
cmdUpdate msg model =
    case msg of
        UpdateRiders riders ->
            Testable.Cmd.none

        MsgForLogin loginMsg ->
            Testable.Cmd.map MsgForLogin <| Login.cmdUpdate loginMsg model.login
