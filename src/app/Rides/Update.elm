module Rides.Update exposing (init, update)

import Form
import Login.Model exposing (User)
import Model as Root exposing (Msg(..))
import RemoteData exposing (..)
import Return exposing (Return, return)
import Rides.Model exposing (..)
import Rides.Ports exposing (createRide, ridesList)
import UrlRouter.Model exposing (Msg(..))
import UrlRouter.Routes exposing (Page(..), pathParser)


init : Collection
init =
    { list = NotAsked
    , new =
        { fields = Form.initial [] (validation "")
        , response = NotAsked
        }
    }


update : Maybe User -> Root.Msg -> Collection -> Return Rides.Model.Msg Collection
update user msg collection =
    case msg of
        MsgForRides msg_ ->
            updateRides user msg_ collection

        MsgForUrlRouter (UrlChange location) ->
            if collection.list == NotAsked then
                case pathParser location of
                    Just (RidesListPage _) ->
                        return { collection | list = Loading } (ridesList ())

                    _ ->
                        return collection Cmd.none
            else
                return collection Cmd.none

        _ ->
            return collection Cmd.none


updateRides : Maybe User -> Rides.Model.Msg -> Collection -> Return Rides.Model.Msg Collection
updateRides user msg collection =
    let
        new =
            collection.new

        fields =
            collection.new.fields

        updateFields fields =
            { collection | new = { new | fields = fields } }
    in
    case msg of
        UpdateRides response ->
            return { collection | list = response } Cmd.none

        FormMsg groupId formMsg ->
            case ( formMsg, Form.getOutput fields ) of
                ( Form.Submit, Just newRide ) ->
                    return { collection | new = { new | response = Loading } }
                        (createRide newRide)

                _ ->
                    return { collection | new = { new | fields = Form.update (validation groupId) formMsg fields } } Cmd.none

        CreateRideResponse response ->
            case response of
                Success _ ->
                    return init Cmd.none

                _ ->
                    return { collection | new = { new | response = response } } Cmd.none
