module Model exposing (Model, Ride, Flags, init)

import Login.Model as Login
import Testable.Cmd


type alias Ride =
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
    { rides : List Ride
    , login : Login.Model
    }


type alias Flags =
    { currentUser : Maybe Login.User
    }


init : Flags -> ( Model, Testable.Cmd.Cmd a )
init { currentUser } =
    ( { rides = []
      , login = Login.init currentUser
      }
    , Testable.Cmd.none
    )
