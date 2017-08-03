module Groups.Model exposing (Group, JoinRequest, Member, Model, Msg(..), isMemberOfGroup)

import Common.Response exposing (Response)
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
    , joinRequests : List JoinRequest
    }


type alias Member =
    { userId : Id, admin : Bool }


type alias JoinRequest =
    { userId : Id, profile : Profile }


type alias Id =
    String


type Msg
    = UpdateGroups (Response (List Group))
    | CreateJoinGroupRequest Id
    | CreateJoinGroupRequestResponse Id (Response Bool)


isMemberOfGroup : Login.Model.Model -> Group -> Bool
isMemberOfGroup login group =
    let
        memberIds =
            List.map .userId group.members
    in
    signedInUser login
        |> Maybe.map (\user -> List.member user.id memberIds)
        |> Maybe.withDefault False
