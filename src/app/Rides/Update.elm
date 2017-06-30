module Rides.Update exposing (init, update)

import Common.IdentifiedList exposing (findById, mapIfId)
import Model as Root exposing (Msg(..))
import Rides.Model exposing (..)
import Rides.Ride.Update as Ride



init : Model
init =
    []


update : Root.Msg -> Model -> ( Model, Cmd.Cmd Rides.Model.Msg )
update msg model =
    case msg of
        MsgForRides msg_ ->
            updateRides msg_ model

        _ ->
            ( model, Cmd.none )


updateRides : Rides.Model.Msg -> Model -> ( Model, Cmd.Cmd Rides.Model.Msg )
updateRides msg model =
    case msg of
        UpdateRides rides ->
            ( rides, Cmd.none )

        MsgForRide rideId msg_ ->
            let
                updateRideModel ride =
                    Tuple.first <| Ride.update msg_ ride

                updateRideCmd ride =
                    Cmd.map (MsgForRide ride.id) <| Tuple.second <| Ride.update msg_ ride

                rides =
                    mapIfId rideId updateRideModel identity model

                cmd =
                    findById rideId model
                        |> Maybe.map updateRideCmd
                        |> Maybe.withDefault Cmd.none
            in
            ( rides, cmd )
