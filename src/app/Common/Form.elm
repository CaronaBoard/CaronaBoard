module Common.Form exposing (customLoadingOrSubmitButton, loadingOrSubmitButton, renderErrors, selectInput, textInput)

import Common.Response exposing (..)
import Form exposing (..)
import Form.Error exposing (..)
import Form.Input as Input
import Html exposing (Attribute, Html, button, div, i, input, label, span, text)
import Html.Attributes exposing (disabled, for, id, placeholder, type_, value)
import Layout.Styles exposing (Classes(..), layoutClass)
import RemoteData exposing (..)


loadingOrSubmitButton : Response a -> String -> List (Html msg) -> Html msg
loadingOrSubmitButton response id_ children =
    customLoadingOrSubmitButton response
        [ layoutClass SubmitButton, id id_ ]
        [ layoutClass DisabledButton, id id_ ]
        children


customLoadingOrSubmitButton : Response a -> List (Attribute msg) -> List (Attribute msg) -> List (Html msg) -> Html msg
customLoadingOrSubmitButton response enabledAttributes disabledAttributes children =
    case response of
        Loading ->
            button ([ disabled True ] ++ disabledAttributes)
                [ div [ layoutClass ButtonContainer ] [ text "Carregando...", i [] [] ] ]

        _ ->
            button enabledAttributes
                [ div [ layoutClass ButtonContainer ] children
                ]


renderErrors : Response a -> Html msg
renderErrors response =
    case response of
        Failure message ->
            renderError <| Just message

        _ ->
            renderError Nothing


renderError : Maybe String -> Html msg
renderError error =
    case error of
        Just error ->
            div [ layoutClass ErrorMessage ] [ text error ]

        Nothing ->
            text ""


textInput : Form.Form e o -> String -> String -> Html Form.Msg
textInput form_ id_ label_ =
    let
        field =
            Form.getFieldAsString id_ form_
    in
    div [ layoutClass InputField ]
        [ Input.textInput field [ id id_, placeholder " " ]
        , errorFor field
        , label [ for id_ ] [ text label_ ]
        ]


selectInput : Form.Form e o -> String -> List ( String, String ) -> Html Form.Msg
selectInput form_ id_ options =
    let
        field =
            Form.getFieldAsString id_ form_
    in
    div [ layoutClass InputField ]
        [ div [ layoutClass SelectWrapper ]
            [ Input.selectInput options field [ id id_, layoutClass SelectField ]
            , span [ layoutClass SelectCaret ] [ text "▼" ]
            ]
        , errorFor field
        ]


errorFor : FieldState e a -> Html msg
errorFor field =
    renderError (Maybe.map errorToString field.liveError)


errorToString : ErrorValue e -> String
errorToString error =
    case error of
        Empty ->
            "este campo é obrigatório"

        InvalidString ->
            "este campo é obrigatório"

        CustomError e ->
            toString e

        _ ->
            "campo inválido"
