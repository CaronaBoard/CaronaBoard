module Profile.Update exposing (init, update)

import Form
import Form.Field as Field
import Login.Model exposing (Msg(SignInResponse))
import Model as Root exposing (Msg(..))
import Profile.Model exposing (Model, Msg(..), Profile, validation)
import Profile.Ports exposing (saveProfile)
import RemoteData exposing (..)
import Return exposing (Return, return)


init : Maybe Profile -> Model
init profile =
    { fields = Form.initial [ ( "contactKind", Field.string "Whatsapp" ) ] validation
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
                    let
                        fillForm =
                            Form.initial
                                [ ( "name", Field.string profile.name )
                                , ( "contactKind", Field.string profile.contact.kind )
                                , ( "contactValue", Field.string profile.contact.value )
                                ]
                                validation
                    in
                    return { model | fields = fillForm, savedProfile = Just profile } Cmd.none

                Nothing ->
                    return (init Nothing) Cmd.none

        _ ->
            return model Cmd.none


updateProfile : Profile.Model.Msg -> Model -> Return Profile.Model.Msg Model
updateProfile msg model =
    case msg of
        FormMsg formMsg ->
            case ( formMsg, Form.getOutput model.fields ) of
                ( Form.Submit, Just profile ) ->
                    return { model | response = Loading }
                        (saveProfile profile)

                _ ->
                    return { model | fields = Form.update validation formMsg model.fields } Cmd.none

        ProfileResponse response ->
            case response of
                Success profile ->
                    return { model | savedProfile = Just profile, response = response } Cmd.none

                _ ->
                    return { model | response = response } Cmd.none
