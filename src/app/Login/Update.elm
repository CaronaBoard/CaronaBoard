module Login.Update exposing (Msg(..), update, cmdUpdate)

import Login.Model exposing (Model, Step(..), User(..))


type Msg
    = UpdateEmail String
    | UpdatePassword String
    | Submit


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateEmail email ->
            { model | email = email }

        UpdatePassword password ->
            { model | password = password }

        Submit ->
            case model.step of
                EmailStep ->
                    { model | step = PasswordStep }

                PasswordStep ->
                    { model | user = Loading }


cmdUpdate : Msg -> Model -> Cmd Msg
cmdUpdate msg model =
    case msg of
        Submit ->
            case model.step of
                EmailStep ->
                    Cmd.none

                PasswordStep ->
                    Cmd.none

        _ ->
            Cmd.none
