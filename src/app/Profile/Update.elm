module Profile.Update exposing (update)

import Common.Response exposing (Response(..), fromFirebase)
import Login.Msg exposing (Msg(SignInResponse))
import Msg as Root exposing (Msg(..))
import Profile.Model exposing (Model)
import Profile.Msg exposing (Msg(..))
import Profile.Ports exposing (saveProfile)
import Testable.Cmd


update : Root.Msg -> Model -> ( Model, Testable.Cmd.Cmd Profile.Msg.Msg )
update msg model =
    case msg of
        MsgForProfile msg_ ->
            updateProfile msg_ model

        MsgForLogin (SignInResponse ( Nothing, Just response )) ->
            case response.profile of
                Just profile ->
                    ( { model | fields = profile }, Testable.Cmd.none )

                Nothing ->
                    ( model, Testable.Cmd.none )

        _ ->
            ( model, Testable.Cmd.none )


updateProfile : Profile.Msg.Msg -> Model -> ( Model, Testable.Cmd.Cmd Profile.Msg.Msg )
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

        UpdateContactType kind ->
            ( updateFields { fields | contact = { contact | kind = kind } }, Testable.Cmd.none )

        UpdateContactValue value ->
            ( updateFields { fields | contact = { contact | value = value } }, Testable.Cmd.none )

        Submit ->
            ( { model | response = Loading }, Testable.Cmd.wrap (saveProfile fields) )

        ProfileResponse response ->
            ( { model | response = fromFirebase response }, Testable.Cmd.none )
