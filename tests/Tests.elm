port module Tests exposing (all)

import Fuzz.UrlRouter.UpdateSpec
import Integration.GroupsSpec
import Integration.LayoutSpec
import Integration.LoginSpec
import Integration.NotificationsSpec
import Integration.ProfileSpec
import Integration.RidesRequestsSpec
import Integration.RidesSpec
import Integration.UrlRouterSpec
import Test exposing (..)
import Unit.Common.DecoderSpec
import Unit.Rides.PortsSpec


all : Test
all =
    describe "CaronaBoard"
        [ Fuzz.UrlRouter.UpdateSpec.tests
        , Integration.RidesSpec.tests
        , Integration.LoginSpec.tests
        , Integration.UrlRouterSpec.tests
        , Integration.LayoutSpec.tests
        , Integration.NotificationsSpec.tests
        , Integration.ProfileSpec.tests
        , Integration.RidesRequestsSpec.tests
        , Unit.Rides.PortsSpec.tests
        , Unit.Common.DecoderSpec.tests
        , Integration.GroupsSpec.tests
        ]
