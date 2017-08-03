port module Groups.Ports exposing (groupsList, groupsListResponse, subscriptions)

import Common.Decoder exposing (normalizeId)
import Common.Response exposing (FirebaseResponse, decodeFromFirebase)
import Groups.Model exposing (Group, Model, Msg(..))
import Json.Decode as Json exposing (..)
import Json.Decode.Pipeline exposing (..)


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ groupsListResponse (decodeFromFirebase decodeGroups >> UpdateGroups)
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
        |> required "users" (list string)


port groupsList : () -> Cmd msg


port groupsListResponse : (FirebaseResponse Json.Value -> msg) -> Sub msg
