module Login.View.Common exposing (loadingOrSubmitButton, renderErrors)

import Testable.Html exposing (Html, div, input, text)
import Testable.Html.Attributes exposing (id, type_, value, disabled)
import Msg as Root
import Login.Model exposing (Model, Step(..), Response(..), step)


loadingOrSubmitButton : String -> Response a -> Html Root.Msg
loadingOrSubmitButton buttonText response =
    case response of
        Loading ->
            input [ type_ "submit", value "Carregando...", disabled True ] []

        _ ->
            input [ type_ "submit", value buttonText ] []


renderErrors : Response a -> Html Root.Msg
renderErrors response =
    case response of
        Error message ->
            div [] [ text message ]

        _ ->
            div [] []
