module Integration.GiveRideSpec exposing (tests)

import Expect exposing (equal)
import GiveRide.Model exposing (Msg(..))
import GiveRide.Ports
import Helpers exposing (expectToContainText, fixtures, initialContext, signedInContext, someUser, toLocation)
import Model exposing (Model)
import Model as Root exposing (Msg(..))
import Navigation
import Notifications.Model exposing (Msg(..))
import Test exposing (..)
import Testable.Html.Selectors exposing (..)
import Testable.TestContext exposing (..)
import UrlRouter.Routes exposing (Page(..), toPath)


tests : Test
tests =
    describe "gives a new ride" <|
        [ test "fill the fields correctly" <|
            fillNewRide
                >> find [ id "origin" ]
                >> assertAttribute "value" (Expect.equal "bar")
        , test "shows loading on submit" <|
            submitNewRide
                >> find [ id "submitNewRide" ]
                >> assertText (Expect.equal "Carregando...")
        , test "sends request via giveRide port" <|
            submitNewRide
                >> assertCalled (Cmd.map MsgForGiveRide <| GiveRide.Ports.giveRide fixtures.newRide)
        , test "shows error when giveRide port returns an error" <|
            submitNewRide
                >> update (MsgForGiveRide <| GiveRideResponse ( Just "Scientists just proved that undefined is indeed not a function", Nothing ))
                >> find []
                >> assertText (expectToContainText "not a function")
        , test "goes to enable notifications page on success" <|
            submitNewRide
                >> successResponse
                >> assertCalled (Cmd.map MsgForUrlRouter <| Navigation.newUrl <| toPath EnableNotificationsPage)
        , test "goes to the rides page on success if notifications are already enabled" <|
            submitNewRide
                >> update (MsgForNotifications <| NotificationsResponse ( Nothing, Just True ))
                >> successResponse
                >> assertCalled (Cmd.map MsgForUrlRouter <| Navigation.newUrl <| toPath RidesPage)
        , test "shows notification on success" <|
            submitNewRide
                >> successResponse
                >> find []
                >> assertText (expectToContainText "Carona criada com sucesso!")
        , test "clear fields on success" <|
            submitNewRide
                >> successResponse
                >> find [ id "origin" ]
                >> assertAttribute "value" (Expect.equal "")
        ]


ridesContext : a -> TestContext Root.Msg Model
ridesContext =
    signedInContext GiveRidePage


fillNewRide : a -> TestContext Root.Msg Model
fillNewRide =
    ridesContext
        >> find [ id "origin" ]
        >> trigger "input" ("{\"target\": {\"value\": \"" ++ fixtures.newRide.origin ++ "\"}}")
        >> find [ id "destination" ]
        >> trigger "input" ("{\"target\": {\"value\": \"" ++ fixtures.newRide.destination ++ "\"}}")
        >> find [ id "days" ]
        >> trigger "input" ("{\"target\": {\"value\": \"" ++ fixtures.newRide.days ++ "\"}}")
        >> find [ id "hours" ]
        >> trigger "input" ("{\"target\": {\"value\": \"" ++ fixtures.newRide.hours ++ "\"}}")


submitNewRide : a -> TestContext Root.Msg Model
submitNewRide =
    fillNewRide
        >> find [ tag "form" ]
        >> trigger "submit" "{}"


successResponse : TestContext Root.Msg Model -> TestContext Root.Msg Model
successResponse =
    update (MsgForGiveRide <| GiveRideResponse ( Nothing, Just True ))
