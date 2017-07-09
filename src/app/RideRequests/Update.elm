module RideRequests.Update exposing (init, update)

import Common.Response exposing (Response(..))
import Model as Root exposing (Msg(..))
import Return exposing (Return, return)
import RideRequests.Model as RideRequests exposing (Model, Msg(..))
import RideRequests.Ports exposing (fetchRideRequest)
import UrlRouter.Model exposing (Msg(..))
import UrlRouter.Routes exposing (Page(..), pathParser)


init : Model
init =
    Empty


update : Root.Msg -> Model -> Return RideRequests.Msg Model
update msg model =
    case msg of
        MsgForRideRequests msg_ ->
            updateRideRequests msg_ model

        MsgForUrlRouter (UrlChange location) ->
            case pathParser location of
                Just (RideRequestPage groupId rideId userId rideRequestId) ->
                    return model
                        (fetchRideRequest
                            { groupId = groupId
                            , rideId = rideId
                            , userId = userId
                            , id = rideRequestId
                            }
                        )

                _ ->
                    return model Cmd.none

        _ ->
            return model Cmd.none


updateRideRequests : RideRequests.Msg -> Model -> Return RideRequests.Msg Model
updateRideRequests msg model =
    case msg of
        FetchedRideRequest response ->
            return response Cmd.none
