module Common.Form exposing (loadingOrSubmitButton, renderErrors)

import Testable.Html exposing (Html, div, button, text, i)
import Testable.Html.Attributes exposing (id, value, disabled, class)
import Login.Msg exposing (Msg(..))
import Common.Response exposing (Response(..))


loadingOrSubmitButton : List (Html Msg) -> Response a -> Html Msg
loadingOrSubmitButton buttonChildren response =
    case response of
        Loading ->
            button [ disabled True, class "waves-effect waves-light btn-large" ]
                [ i [] [], text "Carregando..." ]

        _ ->
            button [ class "waves-effect waves-light btn-large" ] buttonChildren


renderErrors : Response a -> Html Msg
renderErrors response =
    case response of
        Error message ->
            div [] [ text message ]

        _ ->
            div [] []
