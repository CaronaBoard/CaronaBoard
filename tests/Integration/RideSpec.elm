module Integration.RideSpec exposing (tests)

import Common.Response exposing (Response(..))
import Expect exposing (equal)
import Helpers exposing (expectToContainText, fixtures, initialContext, signedInContext, someUser, toLocation)
import Model as Root exposing (Model, Msg(..))
import Rides.Model exposing (Msg(..))
import Rides.Ride.Model exposing (Msg(..))
import Rides.Ride.Ports exposing (RideRequest)
import Test exposing (..)
import Testable.Html.Selectors exposing (..)
import Testable.TestContext exposing (..)
import UrlRouter.Routes exposing (Page(..), toPath)


tests : Test
tests =
    describe "requests a ride" <|
        [ test "shows loading on submit" <|
            submitRide
                >> find [ id "submitRide" ]
                >> assertText (Expect.equal "Carregando...")

        -- TODO: Comparing nested Cmds like this is not working right now
        -- , test "sends request via ride port" <|
        --     submitRide
        --         >> assertCalled (Cmd.map (MsgForRides << MsgForRide "ride-2") <| Rides.Ride.Ports.ride rideRequestExample)
        , test "shows error when ride port returns an error" <|
            submitRide
                >> update (MsgForRides <| MsgForRide "ride-2" <| RideRequestResponse (Error "undefined is not a function"))
                >> find []
                >> assertText (expectToContainText "not a function")
        , test "shows notification on success" <|
            submitRide
                >> successResponse
                >> find []
                >> assertText (expectToContainText "Pedido de carona enviado com sucesso!")
        , test "reveals ride contact" <|
            submitRide
                >> successResponse
                >> find []
                >> assertText (expectToContainText "wpp-for-ride-2")
        ]


ridesContextContext : a -> TestContext Root.Msg Model
ridesContextContext =
    signedInContext (RidePage "ride-2")
        >> update (MsgForRides <| UpdateRides fixtures.rides)


rideRequestExample : RideRequest
rideRequestExample =
    { rideId = "ride-2", toUserId = "user-2" }


submitRide : a -> TestContext Root.Msg Model
submitRide =
    ridesContextContext
        >> find [ tag "form" ]
        >> trigger "submit" "{}"


successResponse : TestContext Root.Msg Model -> TestContext Root.Msg Model
successResponse =
    update (MsgForRides <| MsgForRide "ride-2" <| RideRequestResponse (Success True))
