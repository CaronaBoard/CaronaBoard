module Login.Update exposing (init, update)

import Common.Response exposing (Response(..))
import Login.Model exposing (Model, Msg(..), Step(..), User, step)
import Login.Ports exposing (checkRegistration, passwordReset, signIn, signOut, signUp)
import Model as Root exposing (Msg(MsgForLogin, MsgForUrlRouter))
import Return exposing (Return, return)


init : Maybe User -> Model
init user =
    { email = ""
    , password = ""
    , registered = Empty
    , signedIn =
        user
            |> Maybe.map Success
            |> Maybe.withDefault Empty
    , passwordReset = Empty
    , signUp = Empty
    }


update : Root.Msg -> Model -> Return Login.Model.Msg Model
update msg model =
    case msg of
        MsgForLogin loginMsg ->
            loginUpdate loginMsg model

        _ ->
            return model Cmd.none


loginUpdate : Login.Model.Msg -> Model -> Return Login.Model.Msg Model
loginUpdate msg model =
    case msg of
        UpdateEmail email ->
            return { model | email = email } Cmd.none

        UpdatePassword password ->
            return { model | password = password } Cmd.none

        Submit ->
            case step model of
                EmailStep ->
                    return { model | registered = Loading } <|
                        checkRegistration model.email

                PasswordStep ->
                    return { model | signedIn = Loading } <|
                        signIn { email = model.email, password = model.password }

                NotRegisteredStep ->
                    return { model | signUp = Loading } <|
                        signUp { email = model.email, password = model.password }

        CheckRegistrationResponse response ->
            return { model | registered = response } Cmd.none

        SignInResponse response ->
            return { model | signedIn = Common.Response.map (\res -> res.user) response } Cmd.none

        SignOut ->
            return model (signOut ())

        SignOutResponse response ->
            case response of
                Success _ ->
                    return (init Nothing) Cmd.none

                _ ->
                    return model Cmd.none

        PasswordReset ->
            return { model | passwordReset = Loading } (passwordReset model.email)

        PasswordResetResponse response ->
            return { model | passwordReset = response } Cmd.none

        SignUpResponse response ->
            return { model | signUp = response } Cmd.none
