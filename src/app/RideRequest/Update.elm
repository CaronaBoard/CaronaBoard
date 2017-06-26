module RideRequest.Update exposing (update)

import Common.Response exposing (Response(..), fromFirebase)
import Login.Model exposing (User)
import Msg as Root exposing (Msg(..))
import RideRequest.Model exposing (Model)
import RideRequest.Msg exposing (Msg(..))
import RideRequest.Ports exposing (encodeRideRequest, rideRequest)
import Testable.Cmd


update : Maybe User -> Root.Msg -> Model -> ( Model, Testable.Cmd.Cmd RideRequest.Msg.Msg )
update user msg model =
    case msg of
        MsgForRideRequest msg_ ->
            updateRideRequest user msg_ model

        _ ->
            ( model, Testable.Cmd.none )


updateRideRequest : Maybe User -> RideRequest.Msg.Msg -> Model -> ( Model, Testable.Cmd.Cmd RideRequest.Msg.Msg )
updateRideRequest user msg model =
    let
        fields =
            model.fields

        contact =
            model.fields.contact

        updateFields fields =
            { model | fields = fields }
    in
    case msg of
        UpdateName name ->
            ( updateFields { fields | name = name }, Testable.Cmd.none )

        UpdateContactType kind ->
            ( updateFields { fields | contact = { contact | kind = kind } }, Testable.Cmd.none )

        UpdateContactValue value ->
            ( updateFields { fields | contact = { contact | value = value } }, Testable.Cmd.none )

        Submit ride ->
            case user of
                Just user_ ->
                    ( { model | response = Loading }
                    , Testable.Cmd.wrap (rideRequest (encodeRideRequest ride user_ fields))
                    )

                Nothing ->
                    ( model, Testable.Cmd.none )

        RideRequestResponse response ->
            ( { model | response = fromFirebase response }, Testable.Cmd.none )
