module Login.Update exposing (update)

import Common.Response exposing (Response(..))
import Login.Model exposing (Model, Step(..), User, init, step)
import Login.Msg exposing (Msg(..))
import Login.Ports exposing (checkRegistration, passwordReset, signIn, signOut)
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
                    ( model, Testable.Cmd.none )

        CheckRegistrationResponse isRegistered ->
            ( { model | registered = Success isRegistered }, Testable.Cmd.none )

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
            ( { model | loggedIn = loggedIn }, Testable.Cmd.none )

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
