module Groups.Model
    exposing
        ( Group
        , JoinRequest
        , Member
        , Model
        , Msg(..)
        , NewGroup
        , isMemberOfGroup
        , pendingJoinRequests
        , validation
        )

import Common.Response exposing (..)
import Form exposing (Form)
import Form.Validate as Validate exposing (..)
import Login.Model exposing (signedInUser)
import Profile.Model exposing (Profile)
import RemoteData exposing (..)


type alias Model =
    { list : Response (List Group)
    , new :
        { fields : Form () NewGroup
        , response : Response Bool
        }
    }


type alias Group =
    { id : String
    , name : String
    , members : List Member
    , joinRequest : Response Bool
    , joinRequests : Response (List JoinRequest)
    }


type alias NewGroup =
    { name : String
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
    | FormMsg Form.Msg
    | CreateGroupResponse (Response Bool)


validation : Validation () NewGroup
validation =
    Validate.succeed NewGroup
        |> Validate.andMap (field "name" string)


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
                        NotAsked ->
                            True

                        Failure _ ->
                            True

                        Success _ ->
                            False

                        Loading ->
                            False
                )
                joinRequests

        _ ->
            []
