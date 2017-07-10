module Integration.RidesRequestsSpec exposing (tests)

import Common.Response exposing (Response(..))
import Expect
import Helpers exposing (..)
import JsonStringify exposing (simpleStringify)
import Model as Root exposing (Model, Msg(..))
import Rides.Model exposing (Msg(..))
import RidesRequests.Model exposing (Msg(..))
import RidesRequests.Ports exposing (..)
import Test exposing (..)
import Test.Html.Event exposing (submit)
import Test.Html.Query exposing (..)
import Test.Html.Selector exposing (..)
import TestContext exposing (..)
import UrlRouter.Routes exposing (Page(..), toPath)


tests : Test
tests =
    describe "ride requests" <|
        [ describe "new" <|
            [ test "shows loading on submit" <|
                submitRideRequest
                    >> expectView
                    >> find [ id "submitRideRequest" ]
                    >> has [ text "Carregando..." ]
            , test "sends request via ride port" <|
                submitRideRequest
                    >> expectCmd (RidesRequests.Ports.createRideRequest rideRequestExample)
            , test "shows error when ride port returns an error" <|
                submitRideRequest
                    >> update (MsgForRidesRequests <| CreateRideRequestResponse "idRide2" (Error "undefined is not a function"))
                    >> expectView
                    >> has [ text "not a function" ]
            , test "shows notification on success" <|
                submitRideRequest
                    >> successResponse
                    >> expectView
                    >> has [ text "Pedido de carona enviado com sucesso!" ]
            , test "reveals ride contact" <|
                submitRideRequest
                    >> successResponse
                    >> expectView
                    >> has [ text "wpp-for-idRide2" ]
            ]
        , describe "details" <|
            [ test "fetches ride request for the url sent by the notification" <|
                rideRequestDetails
                    >> expectCmd
                        (fetchRideRequest
                            { groupId = "idGroup1"
                            , rideId = "idRide1"
                            , fromUserId = "idUser1"
                            , id = "idRideRequest1"
                            }
                        )
            , test "shows ride request details" <|
                rideRequestDetails
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
            , test "show loading message while loading" <|
                rideRequestDetails
                    >> expectView
                    >> has [ text "Carregando" ]
            , test "show error message when there is an error" <|
                rideRequestDetails
                    >> send fetchRideRequestResponse ( Just "foo is not a bar", Nothing )
                    >> expectView
                    >> has [ text "foo is not a bar" ]
            ]
        ]


rideRequestDetails : a -> TestContext Root.Model Root.Msg
rideRequestDetails =
    signedInContext GroupsPage
        >> navigate "#/groups/idGroup1/rides/idRide1/requests/idUser1/idRideRequest1"


rideRequestCreate : a -> TestContext Model Root.Msg
rideRequestCreate =
    signedInContext (RideDetailsPage "idGroup1" "idRide2")
        >> update (MsgForRides <| UpdateRides <| Success fixtures.rides)


rideRequestExample : RideRequest
rideRequestExample =
    { groupId = "idGroup1", rideId = "idRide2", toUserId = "isUser2" }


submitRideRequest : a -> TestContext Model Root.Msg
submitRideRequest =
    rideRequestCreate
        >> simulate (find [ tag "form" ]) submit


successResponse : TestContext Model Root.Msg -> TestContext Model Root.Msg
successResponse =
    update (MsgForRidesRequests <| CreateRideRequestResponse "idRide2" (Success True))
