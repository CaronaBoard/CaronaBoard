module Rides.Update exposing (init, update)

import Common.Response exposing (..)
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
        { fields =
            { groupId = ""
            , origin = ""
            , destination = ""
            , days = ""
            , hours = ""
            }
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

        UpdateOrigin origin ->
            return (updateFields { fields | origin = origin }) Cmd.none

        UpdateDestination destination ->
            return (updateFields { fields | destination = destination }) Cmd.none

        UpdateDays days ->
            return (updateFields { fields | days = days }) Cmd.none

        UpdateHours hours ->
            return (updateFields { fields | hours = hours }) Cmd.none

        CreateRide groupId ->
            case user of
                Just user_ ->
                    return { collection | new = { new | response = Loading } }
                        (createRide { fields | groupId = groupId })

                Nothing ->
                    return collection Cmd.none

        CreateRideReponse response ->
            case response of
                Success _ ->
                    return init Cmd.none

                _ ->
                    return { collection | new = { new | response = response } } Cmd.none
