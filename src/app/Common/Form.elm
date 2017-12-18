module Common.Form exposing (..)

import Common.Response exposing (..)
import Form exposing (..)
import Form.Error exposing (..)
import Form.Input as Input
import Html.Attributes
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Layout.Styles exposing (..)
import RemoteData exposing (..)


loadingOrSubmitButton : Response a -> String -> List (Html.Styled.Html msg) -> Html.Styled.Html msg
loadingOrSubmitButton response id_ children =
    customLoadingOrSubmitButton response
        [ layoutClass SubmitButton, Html.Styled.Attributes.id id_ ]
        [ layoutClass DisabledButton, Html.Styled.Attributes.id id_ ]
        children


customLoadingOrSubmitButton : Response a -> List (Html.Styled.Attribute msg) -> List (Html.Styled.Attribute msg) -> List (Html.Styled.Html msg) -> Html.Styled.Html msg
customLoadingOrSubmitButton response enabledAttributes disabledAttributes children =
    case response of
        Loading ->
            Html.Styled.button ([ Html.Styled.Attributes.disabled True ] ++ disabledAttributes)
                [ Html.Styled.div [ layoutClass ButtonContainer ] [ Html.Styled.text "Carregando...", Html.Styled.i [] [] ] ]

        _ ->
            Html.Styled.button enabledAttributes
                [ Html.Styled.div [ layoutClass ButtonContainer ] children
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
    div [ layoutClass InputField ]
        [ div [ layoutClass SelectWrapper ]
            [ Html.Styled.fromUnstyled <|
                Input.selectInput options
                    field
                    [ Html.Attributes.id id_
                    , unlayoutClass SelectField
                    ]
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
