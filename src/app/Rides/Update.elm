module Rides.Update exposing (init, update)

import Common.IdentifiedList exposing (findById, mapIfId)
import Common.Response exposing (Response(..))
import Model as Root exposing (Msg(..))
import Return exposing (Return, return)
import Rides.Model exposing (..)
import Rides.Ports exposing (encodeRide, rideRequest, ridesList)
import UrlRouter.Model exposing (Msg(..))
import UrlRouter.Routes exposing (Page(..), pathParser)


init : Collection
init =
    { rides = Empty }


update : Root.Msg -> Collection -> Return Rides.Model.Msg Collection
update msg model =
    case msg of
        MsgForRides msg_ ->
            updateRides msg_ model

        MsgForUrlRouter (UrlChange location) ->
            if model.rides == Empty then
                case pathParser location of
                    Just (RidesPage _) ->
                        return { model | rides = Loading } (ridesList ())

                    _ ->
                        return model Cmd.none
            else
                return model Cmd.none

        _ ->
            return model Cmd.none


updateRides : Rides.Model.Msg -> Collection -> Return Rides.Model.Msg Collection
updateRides msg collection =
    case msg of
        UpdateRides response ->
            return { rides = response } Cmd.none

        Submit rideId groupId ->
            updateRide rideId
                (\ride ->
                    return { ride | rideRequest = Loading } <|
                        rideRequest (encodeRide groupId ride)
                )
                collection

        RideRequestResponse rideId response ->
            updateRide rideId
                (\ride -> return { ride | rideRequest = response } Cmd.none)
                collection


updateRide : String -> (Model -> ( Model, Cmd Rides.Model.Msg )) -> Collection -> Return Rides.Model.Msg Collection
updateRide id f collection =
    case collection.rides of
        Success rides ->
            mapIfId id f (\model -> return model Cmd.none) rides
                |> Return.sequence
                |> Return.map (\list -> { rides = Success list })

        _ ->
            return collection Cmd.none
