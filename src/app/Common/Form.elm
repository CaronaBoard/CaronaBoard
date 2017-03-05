module Common.Form exposing (loadingOrSubmitButton, renderErrors)

import Testable.Html exposing (Html, Attribute, div, button, text, i)
import Testable.Html.Attributes exposing (id, value, disabled)
import Login.Msg exposing (Msg(..))
import Common.Response exposing (Response(..))
import Layout.Styles exposing (class, Classes(ButtonContainer))
import Common.CssHelpers exposing (materializeClass)


loadingOrSubmitButton : Response a -> List (Attribute Msg) -> List (Html Msg) -> Html Msg
loadingOrSubmitButton response extraAttributes children =
    case response of
        Loading ->
            button ([ disabled True, materializeClass "waves-effect waves-light btn-large" ] ++ extraAttributes)
                [ div [ class ButtonContainer ] [ text "Carregando...", i [] [] ] ]

        _ ->
            button ([ materializeClass "waves-effect waves-light btn-large" ] ++ extraAttributes)
                [ div [ class ButtonContainer ] children
                ]


renderErrors : Response a -> Html Msg
renderErrors response =
    case response of
        Error message ->
            div [] [ text message ]

        _ ->
            div [] []
