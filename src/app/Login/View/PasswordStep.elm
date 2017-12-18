module Login.View.PasswordStep exposing (passwordStep)

import Common.Form exposing (customLoadingOrSubmitButton, renderErrors)
import Common.Icon exposing (icon)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (autofocus, css, for, id, placeholder, type_, value)
import Html.Styled.Events exposing (onInput, onSubmit, onWithOptions)
import Json.Decode as Json
import Layout.Styles exposing (Classes(..), layoutClass)
import Login.Model exposing (Model, Msg(..))
import Login.Styles exposing (..)
import Login.View.Fields exposing (passwordInput)
import Login.View.Layout exposing (formStep)


passwordStep : Model -> Html Msg
passwordStep model =
    formStep <|
        styled form
            Login.Styles.passwordStep
            [ onSubmit SubmitPassword ]
            [ renderErrors model.signedIn
            , renderErrors model.passwordReset
            , styled div filledEmail [] [ text model.email ]
            , passwordInput model.password UpdatePassword "password" "Senha"
            , customLoadingOrSubmitButton model.signedIn
                [ css submitButton, id "submitPassword" ]
                [ layoutClass DisabledButton ]
                [ text "Entrar", Common.Icon.icon "done" ]
            , customLoadingOrSubmitButton model.passwordReset
                [ css resetPasswordButton, id "resetPassword", onWithOptions "click" { stopPropagation = True, preventDefault = True } (Json.succeed PasswordReset) ]
                [ layoutClass DisabledLinkButton, id "resetPassword" ]
                [ text "Esqueci a Senha"
                ]
            ]
