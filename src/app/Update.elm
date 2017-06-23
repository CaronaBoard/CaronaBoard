module Update exposing (update)

import GiveRide.Update as GiveRide
import Layout.Update as Layout
import Login.Model exposing (loggedInUser)
import Login.Update as Login
import Model exposing (Model)
import Msg exposing (Msg(..))
import Rides.Update as Rides
import Testable.Cmd
import UrlRouter.Update as UrlRouter


update : Msg -> Model -> ( Model, Testable.Cmd.Cmd Msg )
update msg model =
    let
        urlRouter =
            UrlRouter.update msg model.urlRouter model.login

        login =
            Login.update msg model.login

        rides =
            Rides.update msg model.rides

        layout =
            Layout.update msg model.layout

        giveRide =
            GiveRide.update (loggedInUser model.login) msg model.giveRide

        updatedModel =
            { urlRouter = Tuple.first urlRouter
            , login = Tuple.first login
            , rides = Tuple.first rides
            , layout = Tuple.first layout
            , giveRide = Tuple.first giveRide
            }

        cmds =
            Testable.Cmd.batch
                [ Testable.Cmd.map MsgForUrlRouter <| Tuple.second urlRouter
                , Testable.Cmd.map MsgForLogin <| Tuple.second login
                , Testable.Cmd.map MsgForRides <| Tuple.second rides
                , Testable.Cmd.map MsgForLayout <| Tuple.second layout
                , Testable.Cmd.map MsgForGiveRide <| Tuple.second giveRide
                ]
    in
    ( updatedModel, cmds )
