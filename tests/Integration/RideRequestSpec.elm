module Integration.RideRequestSpec exposing (tests)

import Expect exposing (equal)
import Helpers exposing (expectToContainText, fixtures, initialContext, signedInContext, someUser, toLocation)
import Model as Root exposing (Model, Msg(..))
import Rides.Model exposing (Msg(..))
import Rides.RideRequest.Model exposing (Msg(..))
import Rides.RideRequest.Ports exposing (RideRequest)
import Test exposing (..)
import Testable.Html.Selectors exposing (..)
import Testable.TestContext exposing (..)
import UrlRouter.Routes exposing (Page(..), toPath)


tests : Test
tests =
    describe "requests a ride" <|
        [ test "shows loading on submit" <|
            submitRideRequest
                >> find [ id "submitRideRequest" ]
                >> assertText (Expect.equal "Carregando...")

        -- TODO: Comparing nested Cmds like this is not working right now
        -- , test "sends request via rideRequest port" <|
        --     submitRideRequest
        --         >> assertCalled (Cmd.map (MsgForRides << MsgForRideRequest "ride-2") <| Rides.RideRequest.Ports.rideRequest rideRequestExample)
        , test "shows error when rideRequest port returns an error" <|
            submitRideRequest
                >> update (MsgForRides <| MsgForRideRequest "ride-2" <| RideRequestResponse ( Just "undefined is not a function", Nothing ))
                >> find []
                >> assertText (expectToContainText "not a function")
        , test "shows notification on success" <|
            submitRideRequest
                >> successResponse
                >> find []
                >> assertText (expectToContainText "Pedido de carona enviado com sucesso!")
        , test "reveals ride contact" <|
            submitRideRequest
                >> successResponse
                >> find []
                >> assertText (expectToContainText "wpp-for-ride-2")
        ]


ridesContextContext : a -> TestContext Root.Msg Model
ridesContextContext =
    signedInContext (RideRequestPage "ride-2")
        >> update (MsgForRides <| UpdateRides fixtures.rides)


rideRequestExample : RideRequest
rideRequestExample =
    { rideId = "ride-2", toUserId = "user-2" }


submitRideRequest : a -> TestContext Root.Msg Model
submitRideRequest =
    ridesContextContext
        >> find [ tag "form" ]
        >> trigger "submit" "{}"


successResponse : TestContext Root.Msg Model -> TestContext Root.Msg Model
successResponse =
    update (MsgForRides <| MsgForRideRequest "ride-2" <| RideRequestResponse ( Nothing, Just True ))
