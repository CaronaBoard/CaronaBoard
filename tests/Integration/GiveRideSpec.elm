module Integration.GiveRideSpec exposing (tests)

import Expect exposing (equal)
import GiveRide.Msg exposing (Msg(..))
import GiveRide.Ports
import Helpers exposing (expectToContainText, initialContext, someUser, toLocation)
import Model exposing (Model)
import Msg as Root exposing (Msg(..))
import Navigation
import Rides.Model exposing (Ride)
import Test exposing (..)
import Testable.Html.Selectors exposing (..)
import Testable.TestContext exposing (..)
import UrlRouter.Routes exposing (Page(..), toPath)


tests : Test
tests =
    describe "gives a new ride" <|
        [ test "fill the fields correctly" <|
            fillNewRide
                >> find [ id "name" ]
                >> assertAttribute "value" (Expect.equal "foo")
        , test "shows loading on submit" <|
            submitNewRide
                >> find [ id "submitNewRide" ]
                >> assertText (Expect.equal "Carregando...")
        , test "sends request via giveRide port" <|
            submitNewRide
                >> assertCalled (Cmd.map MsgForGiveRide <| GiveRide.Ports.giveRide { name = "foo", origin = "bar", destination = "baz, near qux", days = "Mon to Fri", hours = "18:30" })
        , test "shows error when giveRide port returns an error" <|
            submitNewRide
                >> update (MsgForGiveRide <| GiveRideResponse ( Just "Scientists just proved that undefined is indeed not a function", Nothing ))
                >> find []
                >> assertText (expectToContainText "not a function")
        , test "goes to the rides page on success" <|
            successfullySubmitNewRide
                >> assertCalled (Cmd.map MsgForUrlRouter <| Navigation.newUrl <| toPath RidesPage)
        , test "shows notification on success" <|
            successfullySubmitNewRide
                >> find []
                >> assertText (expectToContainText "Carona criada com sucesso!")
        ]


ridesContext : a -> TestContext Root.Msg Model
ridesContext =
    initialContext someUser GiveRidePage


rideExample : Ride
rideExample =
    { id = "1", name = "foo", origin = "bar", destination = "baz, near qux", days = "Mon to Fri", hours = "18:30", formUrl = "" }


fillNewRide : a -> TestContext Root.Msg Model
fillNewRide =
    ridesContext
        >> find [ id "name" ]
        >> trigger "input" ("{\"target\": {\"value\": \"" ++ rideExample.name ++ "\"}}")
        >> find [ id "origin" ]
        >> trigger "input" ("{\"target\": {\"value\": \"" ++ rideExample.origin ++ "\"}}")
        >> find [ id "destination" ]
        >> trigger "input" ("{\"target\": {\"value\": \"" ++ rideExample.destination ++ "\"}}")
        >> find [ id "days" ]
        >> trigger "input" ("{\"target\": {\"value\": \"" ++ rideExample.days ++ "\"}}")
        >> find [ id "hours" ]
        >> trigger "input" ("{\"target\": {\"value\": \"" ++ rideExample.hours ++ "\"}}")


submitNewRide : a -> TestContext Root.Msg Model
submitNewRide =
    fillNewRide
        >> find [ tag "form" ]
        >> trigger "submit" "{}"


successfullySubmitNewRide : a -> TestContext Root.Msg Model
successfullySubmitNewRide =
    submitNewRide
        >> update (MsgForGiveRide <| GiveRideResponse ( Nothing, Just rideExample ))
