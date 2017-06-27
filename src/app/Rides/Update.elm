module Rides.Update exposing (update)

import Common.IdentifiedList exposing (findById, mapIfId)
import Msg as Root exposing (Msg(..))
import Rides.Model exposing (Model)
import Rides.Msg exposing (..)
import Rides.RideRequest.Update as RideRequest
import Testable.Cmd


update : Root.Msg -> Model -> ( Model, Testable.Cmd.Cmd Rides.Msg.Msg )
update msg model =
    case msg of
        MsgForRides (UpdateRides rides) ->
            ( rides, Testable.Cmd.none )

        MsgForRides (MsgForRideRequest rideId msg_) ->
            let
                updateRideModel ride =
                    { ride | rideRequest = Tuple.first <| RideRequest.update msg_ ride.rideRequest }

                updateRideCmd ride =
                    Testable.Cmd.map (MsgForRideRequest ride.id) <| Tuple.second <| RideRequest.update msg_ ride.rideRequest

                rides =
                    mapIfId rideId updateRideModel identity model

                cmd =
                    findById rideId model
                        |> Maybe.map updateRideCmd
                        |> Maybe.withDefault Testable.Cmd.none
            in
            ( rides, cmd )

        _ ->
            ( model, Testable.Cmd.none )
