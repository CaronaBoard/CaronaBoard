module RidesRequests.Update exposing (init, update)

import Common.Response exposing (Response(..))
import Model as Root exposing (Msg(..))
import Return exposing (Return, return)
import RidesRequests.Model as RidesRequests exposing (Model, Msg(..))
import RidesRequests.Ports exposing (fetchRideRequest)
import UrlRouter.Model exposing (Msg(..))
import UrlRouter.Routes exposing (Page(..), pathParser)


init : Model
init =
    Empty


update : Root.Msg -> Model -> Return RidesRequests.Msg Model
update msg model =
    case msg of
        MsgForRidesRequests msg_ ->
            updateRidesRequests msg_ model

        MsgForUrlRouter (UrlChange location) ->
            case pathParser location of
                Just (RideRequestPage groupId rideId fromUserId rideRequestId) ->
                    return model
                        (fetchRideRequest
                            { groupId = groupId
                            , rideId = rideId
                            , fromUserId = fromUserId
                            , id = rideRequestId
                            }
                        )

                _ ->
                    return model Cmd.none

        _ ->
            return model Cmd.none


updateRidesRequests : RidesRequests.Msg -> Model -> Return RidesRequests.Msg Model
updateRidesRequests msg model =
    case msg of
        FetchedRideRequest response ->
            return response Cmd.none
