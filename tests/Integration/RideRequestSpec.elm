module Integration.RideRequestSpec exposing (tests)

import Expect exposing (equal)
import Helpers exposing (expectToContainText, fixtures, initialContext, signedInContext, someUser, toLocation)
import Model exposing (Model)
import Msg as Root exposing (Msg(..))
import RideRequest.Msg exposing (Msg(..))
import RideRequest.Ports exposing (RideRequest)
import Rides.Msg exposing (Msg(..))
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
        , test "sends request via rideRequest port" <|
            submitRideRequest
                >> assertCalled (Cmd.map MsgForRideRequest <| RideRequest.Ports.rideRequest rideRequestExample)
        , test "shows error when rideRequest port returns an error" <|
            submitRideRequest
                >> update (MsgForRideRequest <| RideRequestResponse ( Just "undefined is not a function", Nothing ))
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
    { rideId = "ride-2" }


submitRideRequest : a -> TestContext Root.Msg Model
submitRideRequest =
    ridesContextContext
        >> find [ tag "form" ]
        >> trigger "submit" "{}"


successResponse : TestContext Root.Msg Model -> TestContext Root.Msg Model
successResponse =
    update (MsgForRideRequest <| RideRequestResponse ( Nothing, Just True ))
