module Integration.RidesSpec exposing (tests)

import Css.Helpers exposing (identifierToString)
import Expect exposing (equal)
import Helpers exposing (expectToContainText, initialContext, someUser, toLocation)
import Model exposing (Model)
import Msg as Root exposing (Msg(..))
import Rides.Model exposing (Contact(..), Ride, init)
import Rides.Msg exposing (Msg(..))
import Rides.Styles exposing (Classes(Card))
import Test exposing (..)
import Testable.Html.Selectors exposing (..)
import Testable.Html.Types exposing (Selector)
import Testable.TestContext exposing (..)
import UrlRouter.Routes exposing (Page(..))


tests : Test
tests =
    describe "Rides"
        [ test "renders no routes when there are no rides loaded yet" <|
            ridesContext
                >> findAll [ class Card ]
                >> assertNodeCount (Expect.equal 0)
        , test "renders routes when they load" <|
            ridesContext
                >> update (MsgForRides <| UpdateRides ridesExample)
                >> findAll [ class Card ]
                >> assertNodeCount (Expect.equal 2)
        ]


ridesContext : a -> TestContext Root.Msg Model
ridesContext =
    initialContext someUser RidesPage


ridesExample : List Ride
ridesExample =
    [ { id = "1", name = "foo", origin = "lorem", destination = "ipsum", days = "sit", hours = "amet", contact = Just <| Whatsapp "" }
    , { id = "2", name = "bar", origin = "lorem", destination = "ipsum", days = "sit", hours = "amet", contact = Just <| Whatsapp "" }
    ]


class : Classes -> Selector
class =
    Testable.Html.Selectors.class << identifierToString Rides.Styles.namespace
