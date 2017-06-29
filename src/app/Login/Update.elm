module Login.Update exposing (init, update)

import Common.Response exposing (Response(..))
import Login.Model exposing (Model, Msg(..), Step(..), User, step)
import Login.Ports exposing (checkRegistration, passwordReset, signIn, signOut, signUp)
import Model as Root exposing (Msg(MsgForLogin, MsgForUrlRouter))
import Testable.Cmd


init : Maybe User -> Model
init user =
    { email = ""
    , password = ""
    , registered = Empty
    , loggedIn =
        user
            |> Maybe.map Success
            |> Maybe.withDefault Empty
    , passwordReset = Empty
    , signUp = Empty
    }


update : Root.Msg -> Model -> ( Model, Testable.Cmd.Cmd Login.Model.Msg )
update msg model =
    case msg of
        MsgForLogin loginMsg ->
            loginUpdate loginMsg model

        _ ->
            ( model, Testable.Cmd.none )


loginUpdate : Login.Model.Msg -> Model -> ( Model, Testable.Cmd.Cmd Login.Model.Msg )
loginUpdate msg model =
    case msg of
        UpdateEmail email ->
            ( { model | email = email }, Testable.Cmd.none )

        UpdatePassword password ->
            ( { model | password = password }, Testable.Cmd.none )

        Submit ->
            case step model of
                EmailStep ->
                    ( { model | registered = Loading }, Testable.Cmd.wrap <| checkRegistration model.email )

                PasswordStep ->
                    ( { model | loggedIn = Loading }, Testable.Cmd.wrap <| signIn { email = model.email, password = model.password } )

                NotRegisteredStep ->
                    ( { model | signUp = Loading }, Testable.Cmd.wrap <| signUp { email = model.email, password = model.password } )

        CheckRegistrationResponse response ->
            ( { model | registered = response }, Testable.Cmd.none )

        SignInResponse response ->
            ( { model | loggedIn = Common.Response.map (\res -> res.user) response }, Testable.Cmd.none )

        SignOut ->
            ( model, Testable.Cmd.wrap <| signOut () )

        SignOutResponse response ->
            case response of
                Success _ ->
                    ( init Nothing, Testable.Cmd.none )

                _ ->
                    ( model, Testable.Cmd.none )

        PasswordReset ->
            ( { model | passwordReset = Loading }, Testable.Cmd.wrap <| passwordReset model.email )

        PasswordResetResponse response ->
            ( { model | passwordReset = response }, Testable.Cmd.none )

        SignUpResponse response ->
            ( { model | signUp = response }, Testable.Cmd.none )
