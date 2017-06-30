module Integration.RideSpec exposing (tests)

import Common.Response exposing (Response(..))
import Expect exposing (equal)
import Helpers exposing (expectToContainText, fixtures, initialContext, signedInContext, someUser, toLocation)
import Model as Root exposing (Model, Msg(..))
import Rides.Model exposing (Msg(..))
import Rides.Ride.Model exposing (Msg(..))
import Rides.Ride.Ports exposing (RideRequest)
import Test exposing (..)
import Test.Html.Events as Events exposing (Event(..))
import Test.Html.Query exposing (..)
import Test.Html.Selector exposing (..)
import TestContext exposing (..)
import UrlRouter.Routes exposing (Page(..), toPath)


tests : Test
tests =
    describe "requests a ride" <|
        [ test "shows loading on submit" <|
            submitRide
                >> expectView
                >> find [ id "submitRide" ]
                >> has [ text "Carregando..." ]

        -- TODO: Comparing nested Cmds like this is not working right now
        -- , test "sends request via ride port" <|
        --     submitRide
        --         >> assertCalled (Cmd.map (MsgForRides << MsgForRide "ride-2") <| Rides.Ride.Ports.ride rideRequestExample)
        , test "shows error when ride port returns an error" <|
            submitRide
                >> update (MsgForRides <| MsgForRide "ride-2" <| RideRequestResponse (Error "undefined is not a function"))
                >> expectView
                >> findAll [ text "undefined is not a function" ]
                >> count (Expect.equal 1)
        , test "shows notification on success" <|
            submitRide
                >> successResponse
                >> expectView
                >> findAll [ text "Pedido de carona enviado com sucesso!" ]
                >> count (Expect.equal 1)
        , test "reveals ride contact" <|
            submitRide
                >> successResponse
                >> expectView
                >> findAll [ text "wpp-for-ride-2" ]
                >> count (Expect.equal 1)
        ]


ridesContextContext : a -> TestContext Model Root.Msg
ridesContextContext =
    signedInContext (RidePage "ride-2")
        >> update (MsgForRides <| UpdateRides fixtures.rides)


rideRequestExample : RideRequest
rideRequestExample =
    { rideId = "ride-2", toUserId = "user-2" }


submitRide : a -> TestContext Model Root.Msg
submitRide =
    ridesContextContext
        >> simulate (find [ tag "form" ]) Events.Submit


successResponse : TestContext Model Root.Msg -> TestContext Model Root.Msg
successResponse =
    update (MsgForRides <| MsgForRide "ride-2" <| RideRequestResponse (Success True))
