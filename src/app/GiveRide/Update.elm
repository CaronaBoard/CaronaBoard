module GiveRide.Update exposing (update)

import Common.Response exposing (Response(..), fromFirebase)
import GiveRide.Model exposing (Model)
import GiveRide.Msg exposing (Msg(..))
import GiveRide.Ports exposing (giveRide)
import Msg as Root exposing (Msg(..))
import Testable.Cmd


update : Root.Msg -> Model -> ( Model, Testable.Cmd.Cmd GiveRide.Msg.Msg )
update msg model =
    case msg of
        MsgForGiveRide msg_ ->
            updateGiveRide msg_ model

        _ ->
            ( model, Testable.Cmd.none )


updateGiveRide : GiveRide.Msg.Msg -> Model -> ( Model, Testable.Cmd.Cmd GiveRide.Msg.Msg )
updateGiveRide msg model =
    let
        fields =
            model.fields

        updateFields fields =
            { model | fields = fields }
    in
    case msg of
        UpdateName name ->
            ( updateFields { fields | name = name }, Testable.Cmd.none )

        UpdateOrigin origin ->
            ( updateFields { fields | origin = origin }, Testable.Cmd.none )

        UpdateDestination destination ->
            ( updateFields { fields | destination = destination }, Testable.Cmd.none )

        UpdateDays days ->
            ( updateFields { fields | days = days }, Testable.Cmd.none )

        UpdateHours hours ->
            ( updateFields { fields | hours = hours }, Testable.Cmd.none )

        Submit ->
            ( { model | response = Loading }
            , Testable.Cmd.wrap <|
                giveRide model.fields
            )

        GiveRideResponse response ->
            ( { model | response = fromFirebase response }, Testable.Cmd.none )
