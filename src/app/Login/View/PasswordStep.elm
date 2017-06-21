module Login.View.PasswordStep exposing (passwordStep)

import Common.CssHelpers exposing (materializeClass)
import Common.Form exposing (loadingOrSubmitButton, renderErrors)
import Common.Icon exposing (icon)
import Json.Decode as Json
import Login.Model exposing (Model)
import Login.Msg exposing (Msg(PasswordReset, UpdatePassword))
import Login.Styles exposing (Classes(FilledEmail, PasswordStep, ResetPasswordButton, SubmitButton), class)
import Testable.Html exposing (Html, div, i, input, label, text)
import Testable.Html.Attributes exposing (autofocus, for, id, placeholder, type_, value)
import Testable.Html.Events exposing (onInput, onSubmit, onWithOptions)


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
