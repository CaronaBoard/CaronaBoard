module Common.Decoder exposing (normalizeId, normalizeId2, normalizeId3, normalizeId4)

import Json.Decode as Json exposing (..)


normalizeId : (String -> a -> b) -> Decoder a -> Decoder (List b)
normalizeId f decoder =
    keyValuePairs decoder
        |> map (List.map (\( id, data ) -> f id data))
        |> map List.reverse


normalizeId2 : (String -> String -> a -> b) -> Decoder a -> Decoder (List b)
normalizeId2 f decoder =
    keyValuePairs decoder
        |> keyValuePairs
        |> map (List.concatMap (\( id, data ) -> List.map (\( id2, data2 ) -> f id id2 data2) data))
        |> map List.reverse


normalizeId3 : (String -> String -> String -> a -> b) -> Decoder a -> Decoder (List b)
normalizeId3 f decoder =
    keyValuePairs decoder
        |> keyValuePairs
        |> keyValuePairs
        |> map (List.concatMap (\( id, data ) -> List.concatMap (\( id2, data2 ) -> List.map (\( id3, data3 ) -> f id id2 id3 data3) data2) data))
        |> map List.reverse


normalizeId4 : (String -> String -> String -> String -> a -> b) -> Decoder a -> Decoder (List b)
normalizeId4 f decoder =
    keyValuePairs decoder
        |> keyValuePairs
        |> keyValuePairs
        |> keyValuePairs
        |> map (List.concatMap (\( id, data ) -> List.concatMap (\( id2, data2 ) -> List.concatMap (\( id3, data3 ) -> List.map (\( id4, data4 ) -> f id id2 id3 id4 data4) data3) data2) data))
        |> map List.reverse
