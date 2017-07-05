module Rides.Ride.Update exposing (init, update)

import Common.Response exposing (Response(..))
import Profile.Update
import Return exposing (Return, return)
import Rides.Ride.Model exposing (Model, Msg(..))
import Rides.Ride.Ports exposing (encodeRide, rideRequest)


init : Model
init =
    { id = ""
    , userId = ""
    , groupId = ""
    , origin = ""
    , destination = ""
    , days = ""
    , hours = ""
    , profile = (Profile.Update.init Nothing).fields
    , rideRequest = Empty
    }


update : Rides.Ride.Model.Msg -> Model -> Return Rides.Ride.Model.Msg Model
update msg model =
    case msg of
        Submit ->
            return { model | rideRequest = Loading } <|
                rideRequest (encodeRide model)

        RideRequestResponse response ->
            return { model | rideRequest = response } Cmd.none
