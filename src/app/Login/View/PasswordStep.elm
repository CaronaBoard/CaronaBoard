module Login.View.PasswordStep exposing (passwordStep)

import Testable.Html exposing (Html, div, input, text, i, label)
import Testable.Html.Attributes exposing (id, type_, for, placeholder, value, autofocus)
import Testable.Html.Events exposing (onInput, onSubmit, onWithOptions)
import Login.Msg exposing (Msg(UpdatePassword, PasswordReset))
import Login.Model exposing (Model)
import Common.Form exposing (loadingOrSubmitButton, renderErrors)
import Common.Icon exposing (icon)
import Login.Styles exposing (class, Classes(ResetPasswordButton, SubmitButton, PasswordStep, FilledEmail))
import Common.CssHelpers exposing (materializeClass)
import Json.Decode as Json


passwordStep : Model -> Html Msg
passwordStep model =
    div [ class PasswordStep ]
        [ renderErrors model.loggedIn
        , renderErrors model.passwordReset
        , div [ class FilledEmail ] [ text model.email ]
        , div [ materializeClass "input-field" ]
            [ input
                [ type_ "password"
                , id "password"
                , onInput UpdatePassword
                , value model.password
                , autofocus True
                , placeholder " "
                ]
                []
            , label [ for "password" ] [ text "Senha" ]
            ]
        , loadingOrSubmitButton model.loggedIn [ class SubmitButton ] [ text "Entrar", icon "done" ]
        , loadingOrSubmitButton model.passwordReset
            [ class ResetPasswordButton
            , materializeClass "btn-flat"
            , onWithOptions "click" { stopPropagation = True, preventDefault = True } (Json.succeed PasswordReset)
            ]
            [ text "Esqueci a Senha" ]
        ]
