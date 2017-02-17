module Update exposing (update)

import Model exposing (Model)
import UrlRouter.Update as UrlRouter
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
        MsgForUrlRouter urlRouterMsg ->
            { model | urlRouter = UrlRouter.update urlRouterMsg model.urlRouter model.login }

        MsgForLogin loginMsg ->
            { model | login = Login.update loginMsg model.login }

        MsgForRides ridesMsg ->
            { model | rides = Rides.update ridesMsg model.rides }


cmdUpdate : Msg -> Model -> Testable.Cmd.Cmd Msg
cmdUpdate msg model =
    case msg of
        MsgForUrlRouter urlRouterMsg ->
            Testable.Cmd.map MsgForUrlRouter <| UrlRouter.cmdUpdate urlRouterMsg model.urlRouter model.login

        MsgForLogin loginMsg ->
            Login.cmdUpdate loginMsg model.login

        MsgForRides ridesMsg ->
            Testable.Cmd.none
