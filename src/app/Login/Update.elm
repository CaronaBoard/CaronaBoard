module Login.Update exposing (update, cmdUpdate)

import Login.Model exposing (Model, Response(..), Step(..), User, step)
import Login.Ports exposing (checkRegistration, signIn, signOut)
import Login.Msg exposing (Msg(..))
import Testable.Cmd


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

                NotRegisteredStep ->
                    model

        CheckRegistrationResponse isRegistered ->
            { model | registered = Success isRegistered }

        SignInResponse ( error, success ) ->
            let
                successResponse =
                    success
                        |> Maybe.map Success
                        |> Maybe.withDefault Empty

                loggedIn =
                    error
                        |> Maybe.map Error
                        |> Maybe.withDefault successResponse
            in
                { model | loggedIn = loggedIn }

        SignOut ->
            model

        SignOutResponse ->
            { model | loggedIn = Empty }


cmdUpdate : Msg -> Model -> Testable.Cmd.Cmd Msg
cmdUpdate msg model =
    case msg of
        Submit ->
            case step model of
                EmailStep ->
                    Testable.Cmd.wrap <| checkRegistration model.email

                PasswordStep ->
                    Testable.Cmd.wrap <| signIn { email = model.email, password = model.password }

                NotRegisteredStep ->
                    Testable.Cmd.none

        SignOut ->
            Testable.Cmd.wrap <| signOut ()

        _ ->
            Testable.Cmd.none
