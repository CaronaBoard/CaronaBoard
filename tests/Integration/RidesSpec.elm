module Integration.RidesSpec exposing (tests)

import Css.Helpers exposing (identifierToString)
import Expect exposing (equal)
import GiveRide.Ports
import Helpers exposing (toLocation)
import Login.Model exposing (User)
import Model exposing (Model)
import Msg as Root exposing (Msg(..))
import Rides.Model exposing (Ride, init)
import Rides.Msg exposing (Msg(..))
import Rides.Styles exposing (Classes(Card))
import Test exposing (..)
import Testable.Html.Selectors exposing (..)
import Testable.Html.Types exposing (Selector)
import Testable.TestContext exposing (..)
import Update
import UrlRouter.Routes exposing (Page(..))
import View


tests : Test
tests =
    describe "Rides"
        [ test "renders no routes when there are no rides loaded yet" <|
            ridesContext RidesPage
                >> findAll [ class Card ]
                >> assertNodeCount (Expect.equal 0)
        , test "renders routes when they load" <|
            ridesContext RidesPage
                >> update (MsgForRides <| UpdateRides ridesExample)
                >> findAll [ class Card ]
                >> assertNodeCount (Expect.equal 2)
        , describe "gives a new ride" <|
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
            ]
        ]


ridesContext : Page -> a -> TestContext Root.Msg Model
ridesContext page _ =
    startForTest
        { init = Model.init { currentUser = someUser } (toLocation page)
        , update = Update.update
        , view = View.view
        }


someUser : Maybe User
someUser =
    Just { id = "foo-bar-bar", name = "Baz" }


ridesExample : List Ride
ridesExample =
    [ { id = "1", name = "foo", origin = "lorem", destination = "ipsum", area = "dolor", days = "sit", hours = "amet", flexible = True, formUrl = "http://foo" }
    , { id = "2", name = "bar", origin = "lorem", destination = "ipsum", area = "dolor", days = "sit", hours = "amet", flexible = True, formUrl = "http://foo" }
    ]


class : Classes -> Selector
class =
    Testable.Html.Selectors.class << identifierToString Rides.Styles.namespace


fillNewRide : a -> TestContext Root.Msg Model
fillNewRide =
    ridesContext GiveRidePage
        >> find [ id "name" ]
        >> trigger "input" "{\"target\": {\"value\": \"foo\"}}"
        >> find [ id "origin" ]
        >> trigger "input" "{\"target\": {\"value\": \"bar\"}}"
        >> find [ id "destination" ]
        >> trigger "input" "{\"target\": {\"value\": \"baz, near qux\"}}"
        >> find [ id "days" ]
        >> trigger "input" "{\"target\": {\"value\": \"Mon to Fri\"}}"
        >> find [ id "hours" ]
        >> trigger "input" "{\"target\": {\"value\": \"18:30\"}}"


submitNewRide : a -> TestContext Root.Msg Model
submitNewRide =
    fillNewRide
        >> find [ tag "form" ]
        >> trigger "submit" "{}"
