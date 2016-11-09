module Model exposing (Model, Rider, init)


type alias Rider =
    { id : String, name : String }


type alias Model =
    { riders : List Rider }


init : ( Model, Cmd a )
init =
    ( { riders = [] }, Cmd.none )
