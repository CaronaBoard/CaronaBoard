module Integration.RidesSpec exposing (..)

import Test exposing (..)
import Testable.TestContext exposing (..)
import Testable.Html
import Testable.Html.Selectors exposing (..)
import Expect exposing (equal)
import Rides.Update as Update
import Rides.Model exposing (Model, Ride, init)
import Rides.RoutesList exposing (routesList)
import Rides.Msg exposing (Msg(..))
import Testable.Cmd
import Msg as Root exposing (Msg(MsgForRides))


ridesContext : a -> TestContext Root.Msg Model
ridesContext _ =
    startForTest
        { init = ( init, Testable.Cmd.none )
        , update = (\msg model -> Tuple.mapSecond (Testable.Cmd.map MsgForRides) <| Update.update msg model)
        , view = routesList >> Testable.Html.map MsgForRides
        }


ridesExample : List Ride
ridesExample =
    [ { id = "1", name = "foo", origin = "lorem", destination = "ipsum", area = "dolor", days = "sit", hours = "amet", flexible = True, formUrl = "http://foo" }
    , { id = "2", name = "bar", origin = "lorem", destination = "ipsum", area = "dolor", days = "sit", hours = "amet", flexible = True, formUrl = "http://foo" }
    ]


tests : Test
tests =
    describe "Rides"
        [ test "renders no routes when there are no rides loaded yet" <|
            ridesContext
                >> find [ class "routes-box" ]
                >> thenFindAll [ class "route" ]
                >> assertNodeCount (Expect.equal 0)
        , test "renders routes when they load" <|
            ridesContext
                >> update (MsgForRides <| UpdateRides ridesExample)
                >> findAll [ class "ride-card" ]
                >> assertNodeCount (Expect.equal 2)
        ]
