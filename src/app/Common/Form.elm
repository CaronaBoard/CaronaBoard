module Common.Form exposing (loadingOrSubmitButton, renderErrors, textInput)

import Common.CssHelpers exposing (materializeClass)
import Common.Response exposing (Response(..))
import Html exposing (Attribute, Html, button, div, i, input, label, text)
import Html.Attributes exposing (disabled, for, id, placeholder, value)
import Html.Events exposing (onInput)
import Layout.Styles exposing (Classes(..), layoutClass)


loadingOrSubmitButton : Response a -> List (Attribute msg) -> List (Html msg) -> Html msg
loadingOrSubmitButton response extraAttributes children =
    case response of
        Loading ->
            button ([ disabled True, layoutClass DisabledButton ] ++ extraAttributes)
                [ div [ layoutClass ButtonContainer ] [ text "Carregando...", i [] [] ] ]

        _ ->
            button ([ layoutClass SubmitButton ] ++ extraAttributes)
                [ div [ layoutClass ButtonContainer ] children
                ]


renderErrors : Response a -> Html msg
renderErrors response =
    case response of
        Error message ->
            div [ layoutClass ErrorMessage ] [ text message ]

        _ ->
            div [] []


textInput : String -> (String -> msg) -> String -> String -> Html msg
textInput value_ msg id_ label_ =
    div [ materializeClass "input-field" ]
        [ input
            [ id id_
            , value value_
            , placeholder " "
            , onInput msg
            ]
            []
        , label [ for id_ ] [ text label_ ]
        ]
