module Integration.RoutesBoxSpec exposing (..)

import Test exposing (..)
import Testable.TestContext exposing (..)
import Testable.Html.Selectors exposing (..)
import Expect exposing (equal)
import Update
import Model
import RoutesBox.RoutesList exposing (routesList)
import Msg


routesBoxContext : a -> TestContext Msg.Msg Model.Model
routesBoxContext _ =
    startForTest
        { init = Model.init { currentUser = Nothing }
        , update = Update.update
        , view = routesList
        }


ridersExample : List Model.Rider
ridersExample =
    [ { id = "1", name = "foo" }
    , { id = "2", name = "bar" }
    ]


tests : Test
tests =
    describe "RoutesBox"
        [ test "renders no routes when there are no riders loaded yet" <|
            routesBoxContext
                >> find [ class "routes-box" ]
                >> thenFindAll [ class "route" ]
                >> assertNodeCount (Expect.equal 0)
        , test "renders routes when they load" <|
            routesBoxContext
                >> update (Msg.UpdateRiders ridersExample)
                >> findAll [ class "rider-card" ]
                >> assertNodeCount (Expect.equal 2)
        ]
