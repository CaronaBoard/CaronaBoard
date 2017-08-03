port module Groups.Ports exposing (createJoinGroupRequest, createJoinGroupRequestResponse, groupsList, groupsListResponse, subscriptions)

import Common.Decoder exposing (normalizeId)
import Common.Response exposing (FirebaseResponse, Response(..), decodeFromFirebase)
import Groups.Model exposing (Group, Member, Model, Msg(..))
import Json.Decode as Json exposing (..)
import Json.Decode.Pipeline exposing (..)


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ groupsListResponse (decodeFromFirebase decodeGroups >> UpdateGroups)
        , createJoinGroupRequestResponse
            (\response ->
                CreateJoinGroupRequestResponse response.groupId (decodeFromFirebase bool response.response)
            )
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
        |> required "members" decodeMembers
        -- joinRequest
        |> hardcoded Empty


decodeMembers : Decoder (List Member)
decodeMembers =
    decode Member
        |> hardcoded "userId"
        |> required "admin" bool
        |> normalizeId (\userId member -> { member | userId = userId })


port groupsList : () -> Cmd msg


port groupsListResponse : (FirebaseResponse Json.Value -> msg) -> Sub msg


port createJoinGroupRequest : { groupId : String } -> Cmd msg


port createJoinGroupRequestResponse : ({ groupId : String, response : FirebaseResponse Json.Value } -> msg) -> Sub msg
