port module Main exposing (..)

import Fuzz.UrlRouter.UpdateSpec
import Integration.GiveRideSpec
import Integration.LayoutSpec
import Integration.LoginSpec
import Integration.NotificationsSpec
import Integration.ProfileSpec
import Integration.RideSpec
import Integration.RidesSpec
import Integration.UrlRouterSpec
import Json.Encode exposing (Value)
import Test exposing (..)
import Test.Runner.Node exposing (run)
import Unit.Common.DecoderSpec
import Unit.Rides.PortsSpec


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
        , Integration.RideSpec.tests
        , Integration.ProfileSpec.tests
        , Unit.Rides.PortsSpec.tests
        , Unit.Common.DecoderSpec.tests
        ]


main : Test.Runner.Node.TestProgram
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
