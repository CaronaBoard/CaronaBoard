module Integration.RoutesBoxSpec exposing (..)

import Test exposing (..)
import Testable.TestContext exposing (..)
import Testable.Html.Selectors exposing (..)
import Expect exposing (equal)
import Update
import Model
import RoutesBox.RoutesBox exposing (routesBox)
import Msg


routesBoxContext : a -> TestContext Msg.Msg Model.Model
routesBoxContext _ =
    { init = Model.init
    , update = Update.update
    , view = routesBox
    }
        |> startForTest


ridersExample : List Model.Rider
ridersExample =
    [ { id = "1", name = "foo" }
    , { id = "2", name = "bar" }
    ]


tests : Test
tests =
    describe "Routesbox"
        [ test "renders no routes when there are no riders loaded yet"
            <| routesBoxContext
            >> find [ class "routes-box" ]
            >> thenFindAll [ class "route" ]
            >> assertNodeCount (Expect.equal 0)
        , test "renders routes when they load"
            <| routesBoxContext
            >> update (Msg.UpdateRiders ridersExample)
            >> find [ class "routes-box" ]
            >> thenFindAll [ class "route" ]
            >> assertNodeCount (Expect.equal 2)
        ]
