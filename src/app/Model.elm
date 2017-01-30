module Model exposing (Model, Rider, init)

import Login.Model as Login


type alias Rider =
    { id : String, name : String }


type alias Model =
    { riders : List Rider
    , login : Login.Model
    }


init : ( Model, Cmd a )
init =
    ( { riders = []
      , login = Login.model
      }
    , Cmd.none
    )
