module Integration.RideSpec exposing (tests)

import Common.Response exposing (Response(..))
import Helpers exposing (expectToContainText, fixtures, initialContext, signedInContext, someUser, toLocation)
import Model as Root exposing (Model, Msg(..))
import Rides.Model exposing (Msg(..))
import Rides.Ride.Model exposing (Msg(..))
import Rides.Ride.Ports exposing (RideRequest)
import Test exposing (..)
import Test.Html.Event exposing (submit)
import Test.Html.Query exposing (..)
import Test.Html.Selector exposing (..)
import TestContext exposing (..)
import UrlRouter.Routes exposing (Page(..), toPath)


tests : Test
tests =
    describe "Ride" <|
        [ test "shows loading on submit" <|
            submitRide
                >> expectView
                >> find [ id "submitRide" ]
                >> has [ text "Carregando..." ]
        , test "sends request via ride port" <|
            submitRide
                >> expectCmd (Rides.Ride.Ports.rideRequest rideRequestExample)
        , test "shows error when ride port returns an error" <|
            submitRide
                >> update (MsgForRides <| MsgForRide "idRide2" <| RideRequestResponse (Error "undefined is not a function"))
                >> expectView
                >> has [ text "not a function" ]
        , test "shows notification on success" <|
            submitRide
                >> successResponse
                >> expectView
                >> has [ text "Pedido de carona enviado com sucesso!" ]
        , test "reveals ride contact" <|
            submitRide
                >> successResponse
                >> expectView
                >> has [ text "wpp-for-idRide2" ]
        ]


ridesContextContext : a -> TestContext Model Root.Msg
ridesContextContext =
    signedInContext (RidePage "idGroup1" "idRide2")
        >> update (MsgForRides <| UpdateRides <| Success fixtures.rides)


rideRequestExample : RideRequest
rideRequestExample =
    { groupId = "idGroup1", rideId = "idRide2", toUserId = "isUser2" }


submitRide : a -> TestContext Model Root.Msg
submitRide =
    ridesContextContext
        >> simulate (find [ tag "form" ]) submit


successResponse : TestContext Model Root.Msg -> TestContext Model Root.Msg
successResponse =
    update (MsgForRides <| MsgForRide "idRide2" <| RideRequestResponse (Success True))
