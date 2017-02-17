module Model exposing (Model, Flags, init)

import Router.Model as Router
import Login.Model as Login
import Rides.Model as Rides
import Testable.Cmd
import Navigation exposing (Location)


type alias Model =
    { router : Router.Model
    , login : Login.Model
    , rides : Rides.Model
    }


type alias Flags =
    { currentUser : Maybe Login.User
    }


init : Flags -> Location -> ( Model, Testable.Cmd.Cmd a )
init { currentUser } location =
    ( { router = Router.init location
      , login = Login.init currentUser
      , rides = Rides.init
      }
    , Testable.Cmd.none
    )
