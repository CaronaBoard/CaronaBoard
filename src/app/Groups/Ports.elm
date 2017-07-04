port module Groups.Ports exposing (groupsResponse, subscriptions)

import Common.Decoder exposing (normalizeId)
import Common.Response exposing (fromResult)
import Groups.Model exposing (Group, Model, Msg(..))
import Json.Decode as Json exposing (..)
import Json.Decode.Pipeline exposing (..)


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ groupsResponse (decodeValue decodeGroups >> fromResult >> UpdateGroups)
        ]


decodeGroups : Decoder (List Group)
decodeGroups =
    decodeGroup
        |> normalizeId (\id group -> { group | id = id })


decodeGroup : Decoder Group
decodeGroup =
    decode Group
        |> hardcoded "id"
        |> required "name" string


port groupsResponse : (Json.Value -> msg) -> Sub msg
