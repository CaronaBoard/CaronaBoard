module Common.Form exposing (..)

import Common.Response exposing (..)
import Css
import Form exposing (..)
import Form.Error exposing (..)
import Form.Input as Input
import Html.Attributes
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Layout.Styles exposing (..)
import RemoteData exposing (..)


loadingOrSubmitButton : RemoteData e a -> String -> List (Html msg) -> Html msg
loadingOrSubmitButton response id children =
    customLoadingOrSubmitButton
        { response = response
        , id = id
        , enabledStyle = submitButton
        , disabledStyle = disabledButton
        }
        []
        children


customLoadingOrSubmitButton : { disabledStyle : List Css.Style, enabledStyle : List Css.Style, id : String, response : RemoteData e a } -> List (Attribute msg) -> List (Html msg) -> Html msg
customLoadingOrSubmitButton { response, id, enabledStyle, disabledStyle } attributes children =
    case response of
        Loading ->
            styled Html.Styled.button
                disabledStyle
                [ disabled True, Html.Styled.Attributes.id id ]
                [ styled Html.Styled.div buttonContainer [] [ Html.Styled.text "Carregando...", Html.Styled.i [] [] ] ]

        _ ->
            styled Html.Styled.button
                enabledStyle
                ([ Html.Styled.Attributes.id id ] ++ attributes)
                [ styled Html.Styled.div buttonContainer [] children
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
            styled div errorMessage [] [ text error ]

        Nothing ->
            text ""


textInput : Form.Form e o -> String -> String -> Html Form.Msg
textInput form_ id_ label_ =
    let
        field =
            Form.getFieldAsString id_ form_
    in
    styled div
        inputField
        []
        [ Html.Styled.fromUnstyled <|
            Input.textInput field
                [ Html.Attributes.id id_
                , Html.Attributes.placeholder " "
                ]
        , errorFor field
        , label [ for id_ ] [ text label_ ]
        ]


selectInput : Form.Form e o -> String -> List ( String, String ) -> Html Form.Msg
selectInput form_ id_ options =
    let
        field =
            Form.getFieldAsString id_ form_
    in
    styled div
        inputField
        []
        [ styled div
            selectWrapper
            []
            [ Html.Styled.fromUnstyled <|
                Input.selectInput options
                    field
                    [ Html.Attributes.id id_ ]
            , styled span selectCaret [] [ text "▼" ]
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
