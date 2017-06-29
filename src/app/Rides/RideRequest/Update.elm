module Rides.RideRequest.Update exposing (update)

import Common.Response exposing (Response(..), fromFirebase)
import Rides.Model
import Rides.RideRequest.Model exposing (Model, Msg(..))
import Rides.RideRequest.Ports exposing (encodeRideRequest, rideRequest)
import Testable.Cmd


update : Rides.Model.Ride -> Rides.RideRequest.Model.Msg -> Model -> ( Model, Testable.Cmd.Cmd Rides.RideRequest.Model.Msg )
update ride msg model =
    case msg of
        Submit ->
            ( { model | response = Loading }
            , Testable.Cmd.wrap (rideRequest (encodeRideRequest ride))
            )

        RideRequestResponse response ->
            ( { model | response = fromFirebase response }, Testable.Cmd.none )
