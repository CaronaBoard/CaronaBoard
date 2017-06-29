module Profile.Update exposing (init, update)

import Common.Response exposing (Response(..), fromFirebase)
import Login.Model exposing (Msg(SignInResponse))
import Model as Root exposing (Msg(..))
import Profile.Model exposing (Model, Msg(..), Profile)
import Profile.Ports exposing (saveProfile)
import Testable.Cmd


init : Maybe Profile -> Model
init profile =
    { fields =
        { name = ""
        , contact = { kind = "Whatsapp", value = "" }
        }
    , savedProfile = profile
    , response = Empty
    }


update : Root.Msg -> Model -> ( Model, Testable.Cmd.Cmd Profile.Model.Msg )
update msg model =
    case msg of
        MsgForProfile msg_ ->
            updateProfile msg_ model

        MsgForLogin (SignInResponse ( Nothing, Just response )) ->
            case response.profile of
                Just profile ->
                    ( { model | fields = profile, savedProfile = Just profile }, Testable.Cmd.none )

                Nothing ->
                    ( init Nothing, Testable.Cmd.none )

        _ ->
            ( model, Testable.Cmd.none )


updateProfile : Profile.Model.Msg -> Model -> ( Model, Testable.Cmd.Cmd Profile.Model.Msg )
updateProfile msg model =
    let
        fields =
            model.fields

        contact =
            model.fields.contact

        updateFields fields =
            { model | fields = fields }
    in
    case msg of
        UpdateName name ->
            ( updateFields { fields | name = name }, Testable.Cmd.none )

        UpdateContactKind kind ->
            ( updateFields { fields | contact = { contact | kind = kind } }, Testable.Cmd.none )

        UpdateContactValue value ->
            ( updateFields { fields | contact = { contact | value = value } }, Testable.Cmd.none )

        Submit ->
            ( { model | response = Loading }, Testable.Cmd.wrap (saveProfile fields) )

        ProfileResponse response ->
            case fromFirebase response of
                Success profile ->
                    ( { model | savedProfile = Just profile, response = fromFirebase response }, Testable.Cmd.none )

                _ ->
                    ( { model | response = fromFirebase response }, Testable.Cmd.none )
