module Model exposing (Model, Rider, init)

import Login.Model as Login
import Testable.Cmd


type alias Rider =
    { id : String, name : String }


type alias Model =
    { riders : List Rider
    , login : Login.Model
    }


init : ( Model, Testable.Cmd.Cmd a )
init =
    ( { riders = []
      , login = Login.model
      }
    , Testable.Cmd.none
    )
