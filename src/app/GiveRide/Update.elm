module GiveRide.Update exposing (update)

import Common.Response exposing (Response(..))
import GiveRide.Model exposing (Model)
import GiveRide.Msg exposing (Msg(..))
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
    case msg of
        UpdateName name ->
            ( { model | name = name }, Testable.Cmd.none )

        UpdateOrigin origin ->
            ( { model | origin = origin }, Testable.Cmd.none )

        UpdateDestination destination ->
            ( { model | destination = destination }, Testable.Cmd.none )

        UpdateDays days ->
            ( { model | days = days }, Testable.Cmd.none )

        UpdateHours hours ->
            ( { model | hours = hours }, Testable.Cmd.none )

        Submit ->
            ( { model | response = Loading }, Testable.Cmd.none )
