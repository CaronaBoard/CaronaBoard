port module Main exposing (..)

import Test.Runner.Node exposing (run)
import Json.Encode exposing (Value)
import Test exposing (..)
import ExampleTest exposing (exampleTest)


tests : Test
tests =
    Test.concat
        [ exampleTest ]


main : Program Value
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
