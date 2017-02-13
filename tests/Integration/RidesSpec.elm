module Integration.RidesSpec exposing (..)

import Test exposing (..)
import Testable.TestContext exposing (..)
import Testable.Html.Selectors exposing (..)
import Expect exposing (equal)
import Update
import Model
import Rides.RoutesList exposing (routesList)
import Msg


RidesContext : a -> TestContext Msg.Msg Model.Model
RidesContext _ =
    startForTest
        { init = Model.init { currentUser = Nothing }
        , update = Update.update
        , view = routesList
        }


ridersExample : List Model.Rider
ridersExample =
    [ { id = "1", name = "foo", origin = "lorem", destination = "ipsum", area = "dolor", days = "sit", hours = "amet", flexible = True, formUrl = "http://foo" }
    , { id = "2", name = "bar", origin = "lorem", destination = "ipsum", area = "dolor", days = "sit", hours = "amet", flexible = True, formUrl = "http://foo" }
    ]


tests : Test
tests =
    describe "Rides"
        [ test "renders no routes when there are no riders loaded yet" <|
            RidesContext
                >> find [ class "routes-box" ]
                >> thenFindAll [ class "route" ]
                >> assertNodeCount (Expect.equal 0)
        , test "renders routes when they load" <|
            RidesContext
                >> update (Msg.UpdateRiders ridersExample)
                >> findAll [ class "rider-card" ]
                >> assertNodeCount (Expect.equal 2)
        ]
