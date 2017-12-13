port module Groups.Ports
    exposing
        ( createGroup
        , createGroupResponse
        , createJoinGroupRequest
        , createJoinGroupRequestResponse
        , groupsList
        , groupsListResponse
        , joinRequestsList
        , joinRequestsListResponse
        , respondJoinRequest
        , respondJoinRequestResponse
        , subscriptions
        )

import Common.Decoder exposing (normalizeId, normalizeId2)
import Common.Response exposing (..)
import Groups.Model exposing (..)
import Json.Decode as Json exposing (..)
import Json.Decode.Pipeline exposing (..)
import Profile.Ports exposing (decodeProfile)


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ groupsListResponse (decodeFromFirebase decodeGroups >> UpdateGroups)
        , createJoinGroupRequestResponse
            (\response ->
                CreateJoinGroupRequestResponse response.groupId (decodeFromFirebase bool response.response)
            )
        , respondJoinRequestResponse
            (\response ->
                RespondJoinRequestResponse response.groupId response.userId (decodeFromFirebase bool response.response)
            )
        , joinRequestsListResponse
            (\response ->
                JoinRequestsListResponse response.groupId (decodeFromFirebase decodeJoinRequests response.response)
            )
        , createGroupResponse (fromFirebase >> CreateGroupResponse)
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
        |> optional "members" decodeMembers []
        -- joinRequest
        |> hardcoded Empty
        -- joinRequests
        |> hardcoded Empty


decodeMembers : Decoder (List Member)
decodeMembers =
    decode Member
        |> hardcoded "userId"
        |> required "admin" bool
        |> normalizeId (\userId member -> { member | userId = userId })


decodeJoinRequests : Decoder (List JoinRequest)
decodeJoinRequests =
    decode JoinRequest
        |> hardcoded "userId"
        |> required "profile" decodeProfile
        -- response
        |> hardcoded Empty
        |> normalizeId (\userId joinRequest -> { joinRequest | userId = userId })


port groupsList : () -> Cmd msg


port groupsListResponse : (FirebaseResponse Json.Value -> msg) -> Sub msg


port createJoinGroupRequest : { groupId : String } -> Cmd msg


port createJoinGroupRequestResponse : ({ groupId : String, response : FirebaseResponse Json.Value } -> msg) -> Sub msg


port respondJoinRequest : { groupId : String, userId : String, accepted : Bool } -> Cmd msg


port respondJoinRequestResponse : ({ groupId : String, userId : String, response : FirebaseResponse Json.Value } -> msg) -> Sub msg


port joinRequestsList : { groupId : String } -> Cmd msg


port joinRequestsListResponse : ({ groupId : String, response : FirebaseResponse Json.Value } -> msg) -> Sub msg


port createGroup : NewGroup -> Cmd msg


port createGroupResponse : (FirebaseResponse Bool -> msg) -> Sub msg
