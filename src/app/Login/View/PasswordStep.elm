module Login.View.PasswordStep exposing (passwordStep)

import Common.Form exposing (customLoadingOrSubmitButton, passwordInput, renderErrors)
import Common.Icon exposing (icon)
import Html exposing (..)
import Html.Attributes exposing (autofocus, for, id, placeholder, type_, value)
import Html.Events exposing (onInput, onSubmit, onWithOptions)
import Json.Decode as Json
import Layout.Styles exposing (Classes(..), layoutClass)
import Login.Model exposing (Model, Msg(..))
import Login.Styles exposing (Classes(..), className)
import Login.View.Layout exposing (formStep)


passwordStep : Model -> Html Msg
passwordStep model =
    formStep <|
        form [ className PasswordStep, onSubmit SubmitPassword ]
            [ renderErrors model.signedIn
            , renderErrors model.passwordReset
            , div [ className FilledEmail ] [ text model.email ]
            , passwordInput model.password UpdatePassword "password" "Senha"
            , customLoadingOrSubmitButton model.signedIn
                [ className Login.Styles.SubmitButton ]
                [ layoutClass DisabledButton ]
                [ text "Entrar", icon "done" ]
            , customLoadingOrSubmitButton model.passwordReset
                [ className ResetPasswordButton, id "resetPassword", onWithOptions "click" { stopPropagation = True, preventDefault = True } (Json.succeed PasswordReset) ]
                [ layoutClass DisabledLinkButton, id "resetPassword" ]
                [ text "Esqueci a Senha"
                ]
            ]
