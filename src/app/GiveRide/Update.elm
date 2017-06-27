module GiveRide.Update exposing (update)

import Common.Response exposing (Response(..), fromFirebase)
import GiveRide.Model exposing (Model)
import GiveRide.Msg exposing (Msg(..))
import GiveRide.Ports exposing (giveRide)
import Login.Model exposing (User)
import Msg as Root exposing (Msg(..))
import Testable.Cmd


update : Maybe User -> Root.Msg -> Model -> ( Model, Testable.Cmd.Cmd GiveRide.Msg.Msg )
update user msg model =
    case msg of
        MsgForGiveRide msg_ ->
            updateGiveRide user msg_ model

        _ ->
            ( model, Testable.Cmd.none )


updateGiveRide : Maybe User -> GiveRide.Msg.Msg -> Model -> ( Model, Testable.Cmd.Cmd GiveRide.Msg.Msg )
updateGiveRide user msg model =
    let
        fields =
            model.fields

        updateFields fields =
            { model | fields = fields }
    in
    case msg of
        UpdateOrigin origin ->
            ( updateFields { fields | origin = origin }, Testable.Cmd.none )

        UpdateDestination destination ->
            ( updateFields { fields | destination = destination }, Testable.Cmd.none )

        UpdateDays days ->
            ( updateFields { fields | days = days }, Testable.Cmd.none )

        UpdateHours hours ->
            ( updateFields { fields | hours = hours }, Testable.Cmd.none )

        Submit ->
            case user of
                Just user_ ->
                    ( { model | response = Loading }
                    , Testable.Cmd.wrap (giveRide fields)
                    )

                Nothing ->
                    ( model, Testable.Cmd.none )

        GiveRideResponse response ->
            ( { model | response = fromFirebase response }, Testable.Cmd.none )
