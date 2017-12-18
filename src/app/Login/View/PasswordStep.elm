module Login.View.PasswordStep exposing (passwordStep)

import Common.Form exposing (renderErrors, styledCustomLoadingOrSubmitButton)
import Common.Icon exposing (icon)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (autofocus, css, for, id, placeholder, type_, value)
import Html.Styled.Events exposing (onInput, onSubmit, onWithOptions)
import Json.Decode as Json
import Layout.Styles exposing (Classes(..), styledLayoutClass)
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
            [ fromUnstyled <| renderErrors model.signedIn
            , fromUnstyled <| renderErrors model.passwordReset
            , styled div filledEmail [] [ text model.email ]
            , passwordInput model.password UpdatePassword "password" "Senha"
            , styledCustomLoadingOrSubmitButton model.signedIn
                [ css submitButton, id "submitPassword" ]
                [ styledLayoutClass DisabledButton ]
                [ text "Entrar", fromUnstyled <| Common.Icon.icon "done" ]
            , styledCustomLoadingOrSubmitButton model.passwordReset
                [ css resetPasswordButton, id "resetPassword", onWithOptions "click" { stopPropagation = True, preventDefault = True } (Json.succeed PasswordReset) ]
                [ styledLayoutClass DisabledLinkButton, id "resetPassword" ]
                [ text "Esqueci a Senha"
                ]
            ]
