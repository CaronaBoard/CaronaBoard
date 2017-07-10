module RidesRequests.Update exposing (init, update)

import Common.Response as Response exposing (Response(..))
import Model as Root exposing (Msg(..))
import Return exposing (Return, return)
import RidesRequests.Model as RidesRequests exposing (Collection, Msg(..))
import RidesRequests.Ports exposing (createRideRequest, encodeRideRequest, fetchRideRequest)
import UrlRouter.Model exposing (Msg(..))
import UrlRouter.Routes exposing (Page(..), pathParser)


init : Collection
init =
    { list = Empty
    , new =
        { response = Empty
        }
    }


update : Root.Msg -> Collection -> Return RidesRequests.Msg Collection
update msg collection =
    case msg of
        MsgForRidesRequests msg_ ->
            updateRidesRequests msg_ collection

        MsgForUrlRouter (UrlChange location) ->
            case pathParser location of
                Just (RideRequestDetailsPage groupId rideId fromUserId rideRequestId) ->
                    return { collection | list = Loading }
                        (fetchRideRequest
                            { groupId = groupId
                            , rideId = rideId
                            , fromUserId = fromUserId
                            , id = rideRequestId
                            }
                        )

                _ ->
                    return collection Cmd.none

        _ ->
            return collection Cmd.none


updateRidesRequests : RidesRequests.Msg -> Collection -> Return RidesRequests.Msg Collection
updateRidesRequests msg collection =
    case msg of
        FetchedRideRequest response ->
            return { collection | list = Response.map (\ride -> [ ride ]) response } Cmd.none

        CreateRideRequest ride ->
            return { collection | new = { response = Loading } }
                (createRideRequest <| encodeRideRequest ride)

        CreateRideRequestResponse rideId response ->
            return { collection | new = { response = response } } Cmd.none
