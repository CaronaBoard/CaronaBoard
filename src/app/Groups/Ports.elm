port module Groups.Ports
    exposing
        ( createJoinGroupRequest
        , createJoinGroupRequestResponse
        , groupsList
        , groupsListResponse
        , respondJoinRequest
        , respondJoinRequestResponse
        , subscriptions
        )

import Common.Decoder exposing (normalizeId)
import Common.Response exposing (FirebaseResponse, Response(..), decodeFromFirebase)
import Groups.Model exposing (Group, JoinRequest, Member, Model, Msg(..))
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
        |> optional "joinRequests" decodeJoinRequests []


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
