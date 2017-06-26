module Login.Update exposing (update)

import Common.Response exposing (Response(..), firebaseMap, fromFirebase)
import Login.Model exposing (Model, Step(..), User, init, step)
import Login.Msg exposing (Msg(..))
import Login.Ports exposing (checkRegistration, passwordReset, signIn, signOut, signUp)
import Msg as Root exposing (Msg(MsgForLogin, MsgForUrlRouter))
import Testable.Cmd


update : Root.Msg -> Model -> ( Model, Testable.Cmd.Cmd Login.Msg.Msg )
update msg model =
    case msg of
        MsgForLogin loginMsg ->
            loginUpdate loginMsg model

        _ ->
            ( model, Testable.Cmd.none )


loginUpdate : Login.Msg.Msg -> Model -> ( Model, Testable.Cmd.Cmd Login.Msg.Msg )
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

        CheckRegistrationResponse isRegistered ->
            ( { model | registered = Success isRegistered }, Testable.Cmd.none )

        SignInResponse response ->
            ( { model | loggedIn = fromFirebase (firebaseMap (\res -> res.user) response) }, Testable.Cmd.none )

        SignOut ->
            ( model, Testable.Cmd.wrap <| signOut () )

        SignOutResponse ->
            ( init Nothing, Testable.Cmd.none )

        PasswordReset ->
            ( { model | passwordReset = Loading }, Testable.Cmd.wrap <| passwordReset model.email )

        PasswordResetResponse error ->
            let
                response =
                    Maybe.map Error error
                        |> Maybe.withDefault (Success ())
            in
            ( { model | passwordReset = response }, Testable.Cmd.none )

        SignUpResponse response ->
            ( { model | signUp = fromFirebase response }, Testable.Cmd.none )
