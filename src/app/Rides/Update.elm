module Rides.Update exposing (init, update)

import Common.Response exposing (Response(..))
import Model as Root exposing (Msg(..))
import Return exposing (Return, return)
import Rides.Model exposing (..)
import Rides.Ports exposing (ridesList)
import UrlRouter.Model exposing (Msg(..))
import UrlRouter.Routes exposing (Page(..), pathParser)


init : Collection
init =
    { list = Empty }


update : Root.Msg -> Collection -> Return Rides.Model.Msg Collection
update msg collection =
    case msg of
        MsgForRides msg_ ->
            updateRides msg_ collection

        MsgForUrlRouter (UrlChange location) ->
            if collection.list == Empty then
                case pathParser location of
                    Just (RidesPage _) ->
                        return { collection | list = Loading } (ridesList ())

                    _ ->
                        return collection Cmd.none
            else
                return collection Cmd.none

        _ ->
            return collection Cmd.none


updateRides : Rides.Model.Msg -> Collection -> Return Rides.Model.Msg Collection
updateRides msg collection =
    case msg of
        UpdateRides response ->
            return { list = response } Cmd.none
