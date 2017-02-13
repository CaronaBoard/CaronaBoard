module Model exposing (Model, Flags, init)

import Login.Model as Login
import Rides.Model as Rides
import Testable.Cmd


type alias Model =
    { rides : Rides.Model
    , login : Login.Model
    }


type alias Flags =
    { currentUser : Maybe Login.User
    }


init : Flags -> ( Model, Testable.Cmd.Cmd a )
init { currentUser } =
    ( { rides = Rides.init
      , login = Login.init currentUser
      }
    , Testable.Cmd.none
    )
