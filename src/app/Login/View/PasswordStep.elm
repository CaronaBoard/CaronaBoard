module Login.View.PasswordStep exposing (passwordStep)

import Testable.Html exposing (Html, div, input, text)
import Testable.Html.Attributes exposing (class, type_, placeholder, value, autofocus)
import Testable.Html.Events exposing (onInput, onSubmit)
import Msg as Root
import Login.Msg exposing (Msg(..))
import Login.Model exposing (Model)
import Login.View.Common exposing (loadingOrSubmitButton, renderErrors)


passwordStep : Model -> Html Root.Msg
passwordStep model =
    div [ class "password-step" ]
        [ renderErrors model.loggedIn
        , text model.email
        , input
            [ type_ "password"
            , placeholder "Senha"
            , onInput (Root.MsgForLogin << UpdatePassword)
            , value model.password
            , autofocus True
            ]
            []
        , loadingOrSubmitButton "Entrar" model.loggedIn
        ]
