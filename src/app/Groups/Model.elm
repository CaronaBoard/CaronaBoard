module Groups.Model exposing (Group, JoinRequest, Member, Model, Msg(..), isMemberOfGroup, pendingJoinRequests)

import Common.Response exposing (Response(..))
import Login.Model exposing (signedInUser)
import Profile.Model exposing (Profile)


type alias Model =
    { groups : Response (List Group)
    }


type alias Group =
    { id : String
    , name : String
    , members : List Member
    , joinRequest : Response Bool
    , joinRequests : Response (List JoinRequest)
    }


type alias Member =
    { userId : UserId, admin : Bool }


type alias JoinRequest =
    { userId : UserId, profile : Profile, response : Response Bool }


type alias GroupId =
    String


type alias UserId =
    String


type Msg
    = UpdateGroups (Response (List Group))
    | CreateJoinGroupRequest GroupId
    | CreateJoinGroupRequestResponse GroupId (Response Bool)
    | JoinRequestsListResponse GroupId (Response (List JoinRequest))
    | RespondJoinRequest GroupId UserId Bool
    | RespondJoinRequestResponse GroupId UserId (Response Bool)


isMemberOfGroup : Login.Model.Model -> Group -> Bool
isMemberOfGroup login group =
    let
        memberIds =
            List.map .userId group.members
    in
    signedInUser login
        |> Maybe.map (\user -> List.member user.id memberIds)
        |> Maybe.withDefault False


pendingJoinRequests : Group -> List JoinRequest
pendingJoinRequests group =
    case group.joinRequests of
        Success joinRequests ->
            List.filter
                (\joinRequest ->
                    case joinRequest.response of
                        Empty ->
                            True

                        Error _ ->
                            True

                        Success _ ->
                            False

                        Loading ->
                            False
                )
                joinRequests

        _ ->
            []
