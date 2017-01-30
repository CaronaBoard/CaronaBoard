module Login.Model exposing (Model, model)


type alias Model =
    { email : String
    }


model : Model
model =
    { email = "" }
