module Integration.RequestRideSpec exposing (tests)

import Expect exposing (equal)
import Helpers exposing (expectToContainText, fixtures, initialContext, someUser, toLocation)
import Model exposing (Model)
import Msg as Root exposing (Msg(..))
import Navigation
import Notifications.Msg exposing (Msg(..))
import RideRequest.Msg exposing (Msg(..))
import RideRequest.Ports
import Rides.Model exposing (Contact(..), Ride)
import Rides.Msg exposing (Msg(..))
import Test exposing (..)
import Testable.Html.Selectors exposing (..)
import Testable.TestContext exposing (..)
import UrlRouter.Routes exposing (Page(..), toPath)


tests : Test
tests =
    describe "requests a ride" <|
        [ test "fill the fields correctly" <|
            fillRideRequest
                >> find [ id "name" ]
                >> assertAttribute "value" (Expect.equal "foo")
        , test "shows loading on submit" <|
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


ridesContext : a -> TestContext Root.Msg Model
ridesContext =
    initialContext someUser (RideRequestPage "ride-2")
        >> update (MsgForRides <| UpdateRides fixtures.rides)


rideRequestExample =
    { rideId = "ride-2", userId = "foo-bar-bar", name = "foo", contactType = "Whatsapp", contactValue = "passenger-wpp" }


fillRideRequest : a -> TestContext Root.Msg Model
fillRideRequest =
    ridesContext
        >> find [ id "name" ]
        >> trigger "input" ("{\"target\": {\"value\": \"" ++ rideRequestExample.name ++ "\"}}")
        >> find [ id "contactType" ]
        >> trigger "input" ("{\"target\": {\"value\": \"" ++ rideRequestExample.contactType ++ "\"}}")
        >> find [ id "contactValue" ]
        >> trigger "input" ("{\"target\": {\"value\": \"" ++ rideRequestExample.contactValue ++ "\"}}")


submitRideRequest : a -> TestContext Root.Msg Model
submitRideRequest =
    fillRideRequest
        >> find [ tag "form" ]
        >> trigger "submit" "{}"


successResponse : TestContext Root.Msg Model -> TestContext Root.Msg Model
successResponse =
    update (MsgForRideRequest <| RideRequestResponse ( Nothing, Just True ))
