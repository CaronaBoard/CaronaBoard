module RideRequests.Update exposing (update)

import Model as Root exposing (Msg(..))
import Return exposing (Return, return)
import RideRequests.Ports exposing (fetchRideRequest)
import UrlRouter.Model exposing (Msg(..))
import UrlRouter.Routes exposing (Page(..), pathParser)


update : Root.Msg -> () -> Return () ()
update msg model =
    case msg of
        MsgForUrlRouter (UrlChange location) ->
            case pathParser location of
                Just (RideRequestPage groupId rideId userId rideRequestId) ->
                    return ()
                        (fetchRideRequest
                            { groupId = groupId
                            , rideId = rideId
                            , userId = userId
                            , rideRequestId = rideRequestId
                            }
                        )

                _ ->
                    return () Cmd.none

        _ ->
            return () Cmd.none
