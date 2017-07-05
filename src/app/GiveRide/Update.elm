module GiveRide.Update exposing (init, update)

import Common.Response exposing (Response(..))
import GiveRide.Model exposing (Model, Msg(..))
import GiveRide.Ports exposing (giveRide)
import Login.Model exposing (User)
import Model as Root exposing (Msg(..))
import Return exposing (Return, return)


init : Model
init =
    { fields =
        { groupId = ""
        , origin = ""
        , destination = ""
        , days = ""
        , hours = ""
        }
    , response = Empty
    }


update : Maybe User -> Root.Msg -> Model -> Return GiveRide.Model.Msg Model
update user msg model =
    case msg of
        MsgForGiveRide msg_ ->
            updateGiveRide user msg_ model

        _ ->
            return model Cmd.none


updateGiveRide : Maybe User -> GiveRide.Model.Msg -> Model -> Return GiveRide.Model.Msg Model
updateGiveRide user msg model =
    let
        fields =
            model.fields

        updateFields fields =
            { model | fields = fields }
    in
    case msg of
        UpdateOrigin origin ->
            return (updateFields { fields | origin = origin }) Cmd.none

        UpdateDestination destination ->
            return (updateFields { fields | destination = destination }) Cmd.none

        UpdateDays days ->
            return (updateFields { fields | days = days }) Cmd.none

        UpdateHours hours ->
            return (updateFields { fields | hours = hours }) Cmd.none

        Submit groupId ->
            case user of
                Just user_ ->
                    return { model | response = Loading } (giveRide { fields | groupId = groupId })

                Nothing ->
                    return model Cmd.none

        GiveRideResponse response ->
            case response of
                Success _ ->
                    return init Cmd.none

                _ ->
                    return { model | response = response } Cmd.none
