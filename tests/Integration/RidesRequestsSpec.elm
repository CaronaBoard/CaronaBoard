module Integration.RideRequestsSpec exposing (tests)

import Expect
import Helpers exposing (..)
import JsonStringify exposing (simpleStringify)
import RideRequests.Ports exposing (fetchRideRequest, fetchRideRequestResponse)
import Test exposing (..)
import Test.Html.Query exposing (..)
import Test.Html.Selector exposing (..)
import TestContext exposing (..)
import UrlRouter.Routes exposing (Page(..), toPath)


tests : Test
tests =
    describe "ride requests" <|
        [ test "fetches ride request for the url sent by the notification" <|
            signedInContext GroupsPage
                >> navigate "#/groups/idGroup1/rides/idRide1/requests/idUser1/idRideRequest1"
                >> expectCmd
                    (fetchRideRequest
                        { groupId = "idGroup1"
                        , rideId = "idRide1"
                        , fromUserId = "idUser1"
                        , id = "idRideRequest1"
                        }
                    )
        , test "shows ride request details" <|
            signedInContext GroupsPage
                >> navigate "#/groups/idGroup1/rides/idRide1/requests/idUser1/idRideRequest1"
                >> send fetchRideRequestResponse
                    ( Nothing
                    , Just <|
                        simpleStringify
                            { groupId = "idGroup1"
                            , rideId = "idRide1"
                            , toUserId = "idUser2"
                            , fromUserId = "idUser1"
                            , id = "idRideRequest1"
                            , profile = { name = "Ride McRider", contact = { kind = "Whatsapp", value = "91571" } }
                            }
                    )
                >> expectView
                >> Expect.all
                    [ has [ text "Ride McRider" ]
                    , has [ text "91571" ]
                    ]
        ]
