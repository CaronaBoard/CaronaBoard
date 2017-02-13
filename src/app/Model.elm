module Model exposing (Model, Rider, Flags, init)

import Login.Model as Login
import Testable.Cmd


type alias Rider =
    { id : String
    , name : String
    , origin : String
    , destination : String
    , area : String
    , days : String
    , hours : String
    , flexible : Bool
    , formUrl : String
    }


type alias Model =
    { riders : List Rider
    , login : Login.Model
    }


type alias Flags =
    { currentUser : Maybe Login.User
    }


init : Flags -> ( Model, Testable.Cmd.Cmd a )
init { currentUser } =
    ( { riders = []
      , login = Login.init currentUser
      }
    , Testable.Cmd.none
    )
