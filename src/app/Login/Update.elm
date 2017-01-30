module Login.Update exposing (Msg(..), update)

import Login.Model exposing (Model)


type Msg
    = UpdateEmail String


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateEmail email ->
            { model | email = email }
