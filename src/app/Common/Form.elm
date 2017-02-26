module Common.Form exposing (loadingOrSubmitButton, renderErrors)

import Testable.Html exposing (Html, Attribute, div, button, text, i)
import Testable.Html.Attributes exposing (id, value, disabled, class)
import Login.Msg exposing (Msg(..))
import Common.Response exposing (Response(..))


loadingOrSubmitButton : Response a -> List (Attribute Msg) -> List (Html Msg) -> Html Msg
loadingOrSubmitButton response extraAttributes children =
    case response of
        Loading ->
            button ([ disabled True, class "waves-effect waves-light btn-large" ] ++ extraAttributes)
                [ text "Carregando...", i [] [] ]

        _ ->
            button ([ class "waves-effect waves-light btn-large" ] ++ extraAttributes) children


renderErrors : Response a -> Html Msg
renderErrors response =
    case response of
        Error message ->
            div [] [ text message ]

        _ ->
            div [] []
