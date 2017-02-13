port module Main exposing (..)

import Test.Runner.Node exposing (run)
import Json.Encode exposing (Value)
import Test exposing (..)
import Fuzz.ExampleSpec
import Integration.RidesSpec
import Integration.LoginSpec
import Integration.LayoutSpec


tests : Test
tests =
    Test.concat
        [ Fuzz.ExampleSpec.tests
        , Integration.RidesSpec.tests
        , Integration.LoginSpec.tests
        , Integration.LayoutSpec.tests
        ]


main : Test.Runner.Node.TestProgram
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
