module Login.Update exposing (init, update)

import Common.Response exposing (Response(..))
import Login.Model exposing (Model, Msg(..), Step(..), User, step)
import Login.Ports exposing (checkRegistration, passwordReset, signIn, signOut, signUp)
import Model as Root exposing (Msg(MsgForLogin, MsgForUrlRouter))


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


update : Root.Msg -> Model -> ( Model, Cmd.Cmd Login.Model.Msg )
update msg model =
    case msg of
        MsgForLogin loginMsg ->
            loginUpdate loginMsg model

        _ ->
            ( model, Cmd.none )


loginUpdate : Login.Model.Msg -> Model -> ( Model, Cmd.Cmd Login.Model.Msg )
loginUpdate msg model =
    case msg of
        UpdateEmail email ->
            ( { model | email = email }, Cmd.none )

        UpdatePassword password ->
            ( { model | password = password }, Cmd.none )

        Submit ->
            case step model of
                EmailStep ->
                    ( { model | registered = Loading }, checkRegistration model.email )

                PasswordStep ->
                    ( { model | signedIn = Loading }, signIn { email = model.email, password = model.password } )

                NotRegisteredStep ->
                    ( { model | signUp = Loading }, signUp { email = model.email, password = model.password } )

        CheckRegistrationResponse response ->
            ( { model | registered = response }, Cmd.none )

        SignInResponse response ->
            ( { model | signedIn = Common.Response.map (\res -> res.user) response }, Cmd.none )

        SignOut ->
            ( model, signOut () )

        SignOutResponse response ->
            case response of
                Success _ ->
                    ( init Nothing, Cmd.none )

                _ ->
                    ( model, Cmd.none )

        PasswordReset ->
            ( { model | passwordReset = Loading }, passwordReset model.email )

        PasswordResetResponse response ->
            ( { model | passwordReset = response }, Cmd.none )

        SignUpResponse response ->
            ( { model | signUp = response }, Cmd.none )
