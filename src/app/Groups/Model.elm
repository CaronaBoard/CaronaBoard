module Groups.Model exposing (Group, Model, Msg(..))

import Common.Response exposing (Response)


type alias Model =
    { groups : Response (List Group)
    }


type alias Group =
    { id : String
    , name : String
    }


type Msg
    = UpdateGroups (Response (List Group))
