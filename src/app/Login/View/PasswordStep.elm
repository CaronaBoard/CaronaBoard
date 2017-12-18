module Login.View.PasswordStep exposing (passwordStep)

import Common.Form exposing (customLoadingOrSubmitButton, renderErrors)
import Common.Icon exposing (icon)
import Html.Styled exposing (..)
import Html.Styled.Events exposing (onInput, onSubmit, onWithOptions)
import Json.Decode as Json
import Layout.Styles exposing (..)
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
            , customLoadingOrSubmitButton
                { response = model.signedIn
                , id = "submitPassword"
                , enabledStyle = Layout.Styles.submitButton
                , disabledStyle = disabledButton
                }
                []
                [ text "Entrar", Common.Icon.icon "done" ]
            , customLoadingOrSubmitButton
                { response = model.passwordReset
                , id = "resetPassword"
                , enabledStyle = resetPasswordButton
                , disabledStyle = disabledLinkButton
                }
                [ onWithOptions "click" { stopPropagation = True, preventDefault = True } (Json.succeed PasswordReset) ]
                [ text "Esqueci a Senha"
                ]
            ]
