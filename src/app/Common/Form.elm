module Common.Form exposing (loadingOrSubmitButton, renderErrors, textInput)

import Common.CssHelpers exposing (materializeClass)
import Common.Response exposing (Response(..))
import Layout.Styles exposing (Classes(ButtonContainer), layoutClass)
import Testable.Html exposing (Attribute, Html, button, div, i, input, label, text)
import Testable.Html.Attributes exposing (disabled, for, id, placeholder, value)
import Testable.Html.Events exposing (onInput)


loadingOrSubmitButton : Response a -> List (Attribute msg) -> List (Html msg) -> Html msg
loadingOrSubmitButton response extraAttributes children =
    case response of
        Loading ->
            button ([ disabled True, materializeClass "waves-effect waves-light btn-large" ] ++ extraAttributes)
                [ div [ layoutClass ButtonContainer ] [ text "Carregando...", i [] [] ] ]

        _ ->
            button ([ materializeClass "waves-effect waves-light btn-large" ] ++ extraAttributes)
                [ div [ layoutClass ButtonContainer ] children
                ]


renderErrors : Response a -> Html msg
renderErrors response =
    case response of
        Error message ->
            div [ materializeClass "chip red darken-2 white-text" ] [ text message ]

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
