module Common.Form exposing (customLoadingOrSubmitButton, emailInput, loadingOrSubmitButton, passwordInput, renderErrors, textInput)

import Common.Response exposing (..)
import Html exposing (Attribute, Html, button, div, i, input, label, text)
import Html.Attributes exposing (disabled, for, id, placeholder, type_, value)
import Html.Events exposing (onInput)
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
            div [ layoutClass ErrorMessage ] [ text message ]

        _ ->
            div [] []


textInput : String -> (String -> msg) -> String -> String -> Html msg
textInput =
    input_ "text"


emailInput : String -> (String -> msg) -> String -> String -> Html msg
emailInput =
    input_ "email"


passwordInput : String -> (String -> msg) -> String -> String -> Html msg
passwordInput =
    input_ "password"


input_ : String -> String -> (String -> msg) -> String -> String -> Html msg
input_ inputType value_ msg id_ label_ =
    div [ layoutClass InputField ]
        [ input
            [ id id_
            , type_ inputType
            , value value_
            , placeholder " "
            , onInput msg
            ]
            []
        , label [ for id_ ] [ text label_ ]
        ]
