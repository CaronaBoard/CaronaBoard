module Groups.Model exposing (Group, Model, Msg(..), isMemberOfGroup)

import Common.Response exposing (Response)
import Login.Model exposing (signedInUser)


type alias Model =
    { groups : Response (List Group)
    }


type alias Group =
    { id : String
    , name : String
    , users : List Id
    , joinRequest : Response Bool
    }


type alias Id =
    String


type Msg
    = UpdateGroups (Response (List Group))
    | CreateJoinGroupRequest Id
    | CreateJoinGroupRequestResponse Id (Response Bool)


isMemberOfGroup : Login.Model.Model -> Group -> Bool
isMemberOfGroup login group =
    signedInUser login
        |> Maybe.map (\user -> List.member user.id group.users)
        |> Maybe.withDefault False
