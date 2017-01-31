module Login.Update exposing (Msg(..), update)

import Login.Model exposing (Model, Step(..))


type Msg
    = UpdateEmail String
    | Submit


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateEmail email ->
            { model | email = email }

        Submit ->
            case model.step of
                EmailStep ->
                    { model | step = PasswordStep }

                PasswordStep ->
                    model
