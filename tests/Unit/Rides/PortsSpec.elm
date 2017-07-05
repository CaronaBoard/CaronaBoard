module Unit.Rides.PortsSpec exposing (..)

import Expect
import Helpers exposing (fixtures, jsonQuotes)
import Json.Decode exposing (decodeString)
import Rides.Ports exposing (..)
import Test exposing (..)


tests : Test
tests =
    describe "Rides Ports"
        [ test "decodes rides" <|
            \_ ->
                "{'idGroup1': {'user-1': {'ride-1': {'origin': 'bar', 'destination': 'baz, near qux', 'days': 'Mon to Fri', 'hours': '18:30', 'profile': {'name': 'foo', 'contact': {'kind': 'Whatsapp', 'value': '+5551'}}}}}}"
                    |> jsonQuotes
                    |> decodeString decodeRides
                    |> Expect.equal (Ok [ fixtures.ride ])
        ]
