module GiveRide.Update exposing (init, update)

import Common.Response exposing (Response(..), fromFirebase)
import GiveRide.Model exposing (Model, Msg(..))
import GiveRide.Ports exposing (giveRide)
import Login.Model exposing (User)
import Model as Root exposing (Msg(..))
import Testable.Cmd


init : Model
init =
    { fields =
        { origin = ""
        , destination = ""
        , days = ""
        , hours = ""
        }
    , response = Empty
    }


update : Maybe User -> Root.Msg -> Model -> ( Model, Testable.Cmd.Cmd GiveRide.Model.Msg )
update user msg model =
    case msg of
        MsgForGiveRide msg_ ->
            updateGiveRide user msg_ model

        _ ->
            ( model, Testable.Cmd.none )


updateGiveRide : Maybe User -> GiveRide.Model.Msg -> Model -> ( Model, Testable.Cmd.Cmd GiveRide.Model.Msg )
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
            case fromFirebase response of
                Success _ ->
                    ( init, Testable.Cmd.none )

                _ ->
                    ( { model | response = fromFirebase response }, Testable.Cmd.none )
