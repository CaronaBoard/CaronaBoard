module UpdateSpec exposing (..)

import Test exposing (..)
import Expect exposing (equal)
import Update exposing (update)
import Msg exposing (Msg(UpdateRiders))
import Model exposing (Rider)


ridersExample : List Rider
ridersExample =
    [ { id = "1", name = "foo" } ]


tests : Test
tests =
    describe "Update"
        [ test "replace the riders with the new ones" <|
            \_ ->
                equal
                    { riders = ridersExample }
                    ({ riders = [] }
                        |> update (UpdateRiders ridersExample)
                        |> fst
                    )
        ]
