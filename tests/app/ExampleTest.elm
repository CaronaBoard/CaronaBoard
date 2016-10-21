module ExampleTest exposing (..)

import Test exposing (..)
import Expect exposing (equal)


exampleTest : Test
exampleTest =
    describe "The String module"
        [ test "math test" <|
            \_ -> equal 2 (1 + 1)
        ]
