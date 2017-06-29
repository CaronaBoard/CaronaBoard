module Common.Decoder exposing (normalizeId, normalizeId2)

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