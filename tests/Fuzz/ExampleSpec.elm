module Fuzz.ExampleSpec exposing (..)

import Test exposing (..)
import Expect exposing (equal)
import Fuzz exposing (string)


tests : Test
tests =
    describe "Example"
        [ fuzz string "restores the original string if you run it again"
            <| \randomlyGeneratedString ->
                randomlyGeneratedString
                    |> String.reverse
                    |> String.reverse
                    |> Expect.equal randomlyGeneratedString
        ]
