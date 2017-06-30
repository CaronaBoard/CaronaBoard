module Profile.Update exposing (init, update)

import Common.Response exposing (Response(..))
import Login.Model exposing (Msg(SignInResponse))
import Model as Root exposing (Msg(..))
import Profile.Model exposing (Model, Msg(..), Profile)
import Profile.Ports exposing (saveProfile)


init : Maybe Profile -> Model
init profile =
    { fields =
        { name = ""
        , contact = { kind = "Whatsapp", value = "" }
        }
    , savedProfile = profile
    , response = Empty
    }


update : Root.Msg -> Model -> ( Model, Cmd.Cmd Profile.Model.Msg )
update msg model =
    case msg of
        MsgForProfile msg_ ->
            updateProfile msg_ model

        MsgForLogin (SignInResponse (Success response)) ->
            case response.profile of
                Just profile ->
                    ( { model | fields = profile, savedProfile = Just profile }, Cmd.none )

                Nothing ->
                    ( init Nothing, Cmd.none )

        _ ->
            ( model, Cmd.none )


updateProfile : Profile.Model.Msg -> Model -> ( Model, Cmd.Cmd Profile.Model.Msg )
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
            ( updateFields { fields | name = name }, Cmd.none )

        UpdateContactKind kind ->
            ( updateFields { fields | contact = { contact | kind = kind } }, Cmd.none )

        UpdateContactValue value ->
            ( updateFields { fields | contact = { contact | value = value } }, Cmd.none )

        Submit ->
            ( { model | response = Loading }, saveProfile fields )

        ProfileResponse response ->
            case response of
                Success profile ->
                    ( { model | savedProfile = Just profile, response = response }, Cmd.none )

                _ ->
                    ( { model | response = response }, Cmd.none )
