module Unit.Common.DecoderSpec exposing (..)

import Common.Decoder exposing (..)
import Expect
import Helpers exposing (jsonQuotes)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Test exposing (..)


type alias Sample =
    { id : String, name : String }


type alias SampleNested =
    { id : String, nestedId : String, name : String }


tests : Test
tests =
    describe "Common Decoder"
        [ test "normalize id" <|
            \_ ->
                let
                    decoder : Json.Decode.Decoder (List Sample)
                    decoder =
                        normalizeId (\id model -> { model | id = id })
                            (decode Sample
                                |> hardcoded "id"
                                |> required "name" string
                            )
                in
                "{'foo': {'name': 'lorem'}, 'bar': {'name': 'ipsum'}}"
                    |> jsonQuotes
                    |> decodeString decoder
                    |> Expect.equal (Ok [ Sample "foo" "lorem", Sample "bar" "ipsum" ])
        , test "normalize nested id" <|
            \_ ->
                let
                    decoder : Json.Decode.Decoder (List SampleNested)
                    decoder =
                        normalizeId2 (\id nestedId model -> { model | id = id, nestedId = nestedId })
                            (decode SampleNested
                                |> hardcoded "id"
                                |> hardcoded "userId"
                                |> required "name" string
                            )
                in
                "{'foo': {'baz': {'name': 'lorem'}}, 'bar': {'baz': {'name': 'ipsum'}}}"
                    |> jsonQuotes
                    |> decodeString decoder
                    |> Expect.equal (Ok [ SampleNested "foo" "baz" "lorem", SampleNested "bar" "baz" "ipsum" ])
        ]
