module Login.View.PasswordStep exposing (passwordStep)

import Testable.Html exposing (Html, div, input, text, i, label)
import Testable.Html.Attributes exposing (class, id, type_, for, placeholder, value, autofocus)
import Testable.Html.Events exposing (onInput, onSubmit, onWithOptions)
import Login.Msg exposing (Msg(UpdatePassword, PasswordReset))
import Login.Model exposing (Model)
import Common.Form exposing (loadingOrSubmitButton, renderErrors)
import Common.Icon exposing (iconRight)
import Json.Decode as Json


passwordStep : Model -> Html Msg
passwordStep model =
    div [ class "password-step" ]
        [ renderErrors model.loggedIn
        , renderErrors model.passwordReset
        , text model.email
        , div [ class "input-field" ]
            [ input
                [ type_ "password"
                , id "password"
                , onInput UpdatePassword
                , value model.password
                , autofocus True
                ]
                []
            , label [ for "password" ] [ text "Senha" ]
            ]
        , loadingOrSubmitButton model.loggedIn [] [ iconRight "done", text "Entrar" ]
        , loadingOrSubmitButton model.passwordReset
            [ class "btn-flat"
            , id "password-reset-button"
            , onWithOptions "click" { stopPropagation = True, preventDefault = True } (Json.succeed PasswordReset)
            ]
            [ text "Esqueci a Senha" ]
        ]
