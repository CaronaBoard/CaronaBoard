module Integration.RideRequestsSpec exposing (tests)

import Helpers exposing (expectCurrentPage, expectToContainText, fixtures, initialContext, signedInContext, someUser, toLocation)
import RideRequests.Ports
import Test exposing (..)
import TestContext exposing (..)
import UrlRouter.Routes exposing (Page(..), toPath)


tests : Test
tests =
    describe "ride requests" <|
        [ test "fetches ride request details for the url sent by the notification" <|
            signedInContext GroupsPage
                >> navigate "#/groups/idGroup1/rides/idRide1/requests/idUser1/idRideRequest1"
                >> expectCmd (RideRequests.Ports.fetchRideRequest { groupId = "idGroup1", rideId = "idRide1", userId = "idUser1", rideRequestId = "idRideRequest1" })
        ]
