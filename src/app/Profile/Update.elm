module Profile.Update exposing (init, update)

import Login.Model exposing (Msg(SignInResponse))
import Model as Root exposing (Msg(..))
import Profile.Model exposing (Model, Msg(..), Profile)
import Profile.Ports exposing (saveProfile)
import RemoteData exposing (..)
import Return exposing (Return, return)


init : Maybe Profile -> Model
init profile =
    { fields =
        { name = ""
        , contact = { kind = "Whatsapp", value = "" }
        }
    , savedProfile = profile
    , response = NotAsked
    }


update : Root.Msg -> Model -> Return Profile.Model.Msg Model
update msg model =
    case msg of
        MsgForProfile msg_ ->
            updateProfile msg_ model

        MsgForLogin (SignInResponse (Success response)) ->
            case response.profile of
                Just profile ->
                    return { model | fields = profile, savedProfile = Just profile } Cmd.none

                Nothing ->
                    return (init Nothing) Cmd.none

        _ ->
            return model Cmd.none


updateProfile : Profile.Model.Msg -> Model -> Return Profile.Model.Msg Model
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
            return (updateFields { fields | name = name }) Cmd.none

        UpdateContactKind kind ->
            return (updateFields { fields | contact = { contact | kind = kind } }) Cmd.none

        UpdateContactValue value ->
            return (updateFields { fields | contact = { contact | value = value } }) Cmd.none

        Submit ->
            return { model | response = Loading } (saveProfile fields)

        ProfileResponse response ->
            case response of
                Success profile ->
                    return { model | savedProfile = Just profile, response = response } Cmd.none

                _ ->
                    return { model | response = response } Cmd.none
