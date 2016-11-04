module Model exposing (Model, Rider)


type alias Rider =
    { id : String, name : String }


type alias Model =
    { riders : List Rider }
