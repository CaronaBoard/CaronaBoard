module Integration.RidesSpec exposing (tests)

import Css.Helpers exposing (identifierToString)
import Expect exposing (equal)
import Msg as Root exposing (Msg(MsgForRides))
import Rides.Model exposing (Model, Ride, init)
import Rides.Msg exposing (Msg(..))
import Rides.Styles exposing (Classes(Card))
import Rides.Update as Update
import Rides.View.RoutesList exposing (routesList)
import Test exposing (..)
import Testable.Cmd
import Testable.Html
import Testable.Html.Selectors exposing (..)
import Testable.Html.Types exposing (Selector)
import Testable.TestContext exposing (..)


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
ridesContext _ =
    startForTest
        { init = ( init, Testable.Cmd.none )
        , update = \msg model -> Tuple.mapSecond (Testable.Cmd.map MsgForRides) <| Update.update msg model
        , view = routesList >> Testable.Html.map MsgForRides
        }


ridesExample : List Ride
ridesExample =
    [ { id = "1", name = "foo", origin = "lorem", destination = "ipsum", area = "dolor", days = "sit", hours = "amet", flexible = True, formUrl = "http://foo" }
    , { id = "2", name = "bar", origin = "lorem", destination = "ipsum", area = "dolor", days = "sit", hours = "amet", flexible = True, formUrl = "http://foo" }
    ]


class : Classes -> Selector
class =
    Testable.Html.Selectors.class << identifierToString Rides.Styles.namespace
