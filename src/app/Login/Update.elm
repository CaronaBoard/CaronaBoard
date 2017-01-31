module Login.Update exposing (update, cmdUpdate)

import Login.Model exposing (Model, Response(..), LoggedIn(..), Step(..), User, step)
import Login.Ports exposing (checkRegistration, signIn)
import Login.Msg exposing (Msg(..))


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateEmail email ->
            { model | email = email }

        UpdatePassword password ->
            { model | password = password }

        Submit ->
            case step model of
                EmailStep ->
                    { model | registered = Loading }

                PasswordStep ->
                    { model | loggedIn = Loading }

        CheckRegistrationResponse isRegistered ->
            { model | registered = Success isRegistered }

        SignInResponse ( error, success ) ->
            let
                successResponse =
                    success
                        |> Maybe.map (Success << LoggedIn)
                        |> Maybe.withDefault Empty

                loggedIn =
                    error
                        |> Maybe.map Error
                        |> Maybe.withDefault successResponse
            in
                { model | loggedIn = loggedIn }


cmdUpdate : Msg -> Model -> Cmd Msg
cmdUpdate msg model =
    case msg of
        Submit ->
            case step model of
                EmailStep ->
                    checkRegistration model.email

                PasswordStep ->
                    signIn { email = model.email, password = model.password }

        _ ->
            Cmd.none
