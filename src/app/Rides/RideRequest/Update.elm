module Rides.RideRequest.Update exposing (update)

import Common.Response exposing (Response(..), fromFirebase)
import Rides.RideRequest.Model exposing (Model)
import Rides.RideRequest.Msg exposing (Msg(..))
import Rides.RideRequest.Ports exposing (encodeRideRequest, rideRequest)
import Testable.Cmd


update : Rides.RideRequest.Msg.Msg -> Model -> ( Model, Testable.Cmd.Cmd Rides.RideRequest.Msg.Msg )
update msg model =
    case msg of
        Submit ride ->
            ( { model | response = Loading }
            , Testable.Cmd.wrap (rideRequest (encodeRideRequest ride))
            )

        RideRequestResponse response ->
            ( { model | response = fromFirebase response }, Testable.Cmd.none )
