module Login.View.Registration exposing (registrationStep)

import Common.Form exposing (renderErrors, styledCustomLoadingOrSubmitButton)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)
import Html.Styled.Events exposing (onInput, onSubmit)
import Layout.Styles exposing (Classes(..), styledLayoutClass)
import Login.Model exposing (Model, Msg(..))
import Login.Styles exposing (..)
import Login.View.Fields exposing (emailInput, passwordInput)


registrationStep : Model -> Html Msg
registrationStep model =
    styled div
        background
        []
        [ styled div
            Login.Styles.container
            []
            [ styled div
                stepTitle
                []
                [ h1 [] [ text "Cadastro" ]
                , p []
                    [ text "Parece que esse email ainda não está cadastrado, faça seu cadastro para continuar"
                    ]
                ]
            , styled div
                stepForm
                []
                [ registration model
                ]
            ]
        ]


registration : Model -> Html Msg
registration model =
    form [ onSubmit SubmitRegistration ]
        [ fromUnstyled <| renderErrors model.signUp
        , emailInput model.email UpdateEmail "email" "Email"
        , passwordInput model.password UpdatePassword "password" "Nova Senha"
        , styledCustomLoadingOrSubmitButton model.signUp
            [ css Login.Styles.submitButton ]
            [ styledLayoutClass DisabledButton ]
            [ text "Cadastrar" ]
        ]
