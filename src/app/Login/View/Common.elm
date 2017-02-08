module Login.View.Common exposing (loadingOrSubmitButton, renderErrors)

import Testable.Html exposing (Html, div, button, text)
import Testable.Html.Attributes exposing (id, value, disabled, class)
import Login.Model exposing (Model, Step(..), Response(..), step)
import Login.Msg exposing (Msg(..))


loadingOrSubmitButton : List (Html Msg) -> Response a -> Html Msg
loadingOrSubmitButton buttonChildren response =
    case response of
        Loading ->
            button [ disabled True, class "waves-effect waves-light btn-large" ] buttonChildren

        _ ->
            button [ class "waves-effect waves-light btn-large" ] buttonChildren


renderErrors : Response a -> Html Msg
renderErrors response =
    case response of
        Error message ->
            div [] [ text message ]

        _ ->
            div [] []
