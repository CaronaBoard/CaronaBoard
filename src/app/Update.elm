module Update exposing (update)

import Model exposing (Model)
import Router.Update as Router
import Login.Update as Login
import Rides.Update as Rides
import Msg exposing (Msg(..))
import Testable.Cmd


update : Msg -> Model -> ( Model, Testable.Cmd.Cmd Msg )
update msg model =
    ( modelUpdate msg model, cmdUpdate msg model )


modelUpdate : Msg -> Model -> Model
modelUpdate msg model =
    case msg of
        MsgForRouter routerMsg ->
            { model | router = Router.update routerMsg model.router model.login }

        MsgForLogin loginMsg ->
            { model | login = Login.update loginMsg model.login }

        MsgForRides ridesMsg ->
            { model | rides = Rides.update ridesMsg model.rides }


cmdUpdate : Msg -> Model -> Testable.Cmd.Cmd Msg
cmdUpdate msg model =
    case msg of
        MsgForRouter routerMsg ->
            Testable.Cmd.map MsgForRouter <| Router.cmdUpdate routerMsg model.router model.login

        MsgForLogin loginMsg ->
            Testable.Cmd.map MsgForLogin <| Login.cmdUpdate loginMsg model.login

        MsgForRides ridesMsg ->
            Testable.Cmd.none
