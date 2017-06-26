port module Main exposing (..)

import Fuzz.UrlRouter.UpdateSpec
import Integration.GiveRideSpec
import Integration.LayoutSpec
import Integration.LoginSpec
import Integration.NotificationsSpec
import Integration.RideRequestSpec
import Integration.RidesSpec
import Integration.UrlRouterSpec
import Json.Encode exposing (Value)
import Test exposing (..)
import Test.Runner.Node exposing (run)


tests : Test
tests =
    Test.concat
        [ Fuzz.UrlRouter.UpdateSpec.tests
        , Integration.RidesSpec.tests
        , Integration.LoginSpec.tests
        , Integration.UrlRouterSpec.tests
        , Integration.LayoutSpec.tests
        , Integration.GiveRideSpec.tests
        , Integration.NotificationsSpec.tests
        , Integration.RideRequestSpec.tests
        ]


main : Test.Runner.Node.TestProgram
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
