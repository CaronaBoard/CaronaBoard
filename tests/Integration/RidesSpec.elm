module Integration.RidesSpec exposing (..)

import Test exposing (..)
import Testable.TestContext exposing (..)
import Testable.Html.Selectors exposing (..)
import Expect exposing (equal)
import Update
import Model
import Rides.RoutesList exposing (routesList)
import Msg


ridesContext : a -> TestContext Msg.Msg Model.Model
ridesContext _ =
    startForTest
        { init = Model.init { currentUser = Nothing }
        , update = Update.update
        , view = routesList
        }


ridesExample : List Model.Ride
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
                >> update (Msg.UpdateRides ridesExample)
                >> findAll [ class "ride-card" ]
                >> assertNodeCount (Expect.equal 2)
        ]
