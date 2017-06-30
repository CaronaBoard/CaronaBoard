module GiveRide.Update exposing (init, update)

import Common.Response exposing (Response(..))
import GiveRide.Model exposing (Model, Msg(..))
import GiveRide.Ports exposing (giveRide)
import Login.Model exposing (User)
import Model as Root exposing (Msg(..))


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


update : Maybe User -> Root.Msg -> Model -> ( Model, Cmd.Cmd GiveRide.Model.Msg )
update user msg model =
    case msg of
        MsgForGiveRide msg_ ->
            updateGiveRide user msg_ model

        _ ->
            ( model, Cmd.none )


updateGiveRide : Maybe User -> GiveRide.Model.Msg -> Model -> ( Model, Cmd.Cmd GiveRide.Model.Msg )
updateGiveRide user msg model =
    let
        fields =
            model.fields

        updateFields fields =
            { model | fields = fields }
    in
    case msg of
        UpdateOrigin origin ->
            ( updateFields { fields | origin = origin }, Cmd.none )

        UpdateDestination destination ->
            ( updateFields { fields | destination = destination }, Cmd.none )

        UpdateDays days ->
            ( updateFields { fields | days = days }, Cmd.none )

        UpdateHours hours ->
            ( updateFields { fields | hours = hours }, Cmd.none )

        Submit ->
            case user of
                Just user_ ->
                    ( { model | response = Loading }
                    , giveRide fields
                    )

                Nothing ->
                    ( model, Cmd.none )

        GiveRideResponse response ->
            case response of
                Success _ ->
                    ( init, Cmd.none )

                _ ->
                    ( { model | response = response }, Cmd.none )
