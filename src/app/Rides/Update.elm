module Rides.Update exposing (init, update)

import Common.IdentifiedList exposing (findById, mapIfId)
import Model as Root exposing (Msg(..))
import Rides.Model exposing (..)
import Rides.RideRequest.Update as RideRequest
import Testable.Cmd


init : Model
init =
    []


update : Root.Msg -> Model -> ( Model, Testable.Cmd.Cmd Rides.Model.Msg )
update msg model =
    case msg of
        MsgForRides msg_ ->
            updateRides msg_ model

        _ ->
            ( model, Testable.Cmd.none )


updateRides : Rides.Model.Msg -> Model -> ( Model, Testable.Cmd.Cmd Rides.Model.Msg )
updateRides msg model =
    case msg of
        UpdateRides rides ->
            ( rides, Testable.Cmd.none )

        MsgForRideRequest rideId msg_ ->
            let
                updateRideModel ride =
                    { ride | rideRequest = Tuple.first <| RideRequest.update ride msg_ ride.rideRequest }

                updateRideCmd ride =
                    Testable.Cmd.map (MsgForRideRequest ride.id) <| Tuple.second <| RideRequest.update ride msg_ ride.rideRequest

                rides =
                    mapIfId rideId updateRideModel identity model

                cmd =
                    findById rideId model
                        |> Maybe.map updateRideCmd
                        |> Maybe.withDefault Testable.Cmd.none
            in
            ( rides, cmd )
