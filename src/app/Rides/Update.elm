module Rides.Update exposing (init, update)

import Common.IdentifiedList exposing (findById, mapIfId)
import Common.Response exposing (Response(..))
import Model as Root exposing (Msg(..))
import Return exposing (Return, return)
import Rides.Model exposing (..)
import Rides.Ports exposing (ridesList)
import Rides.Ride.Update as Ride
import UrlRouter.Model exposing (Msg(..))
import UrlRouter.Routes exposing (Page(..), pathParser)


init : Model
init =
    { rides = Empty }


update : Root.Msg -> Model -> Return Rides.Model.Msg Model
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


updateRides : Rides.Model.Msg -> Model -> Return Rides.Model.Msg Model
updateRides msg model =
    case msg of
        UpdateRides response ->
            return { rides = response } Cmd.none

        MsgForRide rideId msg_ ->
            case model.rides of
                Success rides ->
                    let
                        updateRideModel ride =
                            Tuple.first <| Ride.update msg_ ride

                        updateRideCmd ride =
                            Cmd.map (MsgForRide ride.id) <| Tuple.second <| Ride.update msg_ ride

                        updatedRides =
                            mapIfId rideId updateRideModel identity rides

                        cmd =
                            findById rideId rides
                                |> Maybe.map updateRideCmd
                                |> Maybe.withDefault Cmd.none
                    in
                    return { rides = Success updatedRides } cmd

                _ ->
                    return model Cmd.none
