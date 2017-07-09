module Login.View.Registration exposing (registrationStep)

import Common.Form exposing (customLoadingOrSubmitButton, emailInput, passwordInput, renderErrors, textInput)
import Html exposing (..)
import Html.Events exposing (onInput, onSubmit)
import Layout.Styles exposing (Classes(..), layoutClass)
import Login.Model exposing (Model, Msg(..))
import Login.Styles exposing (Classes(..), className)


registrationStep : Model -> Html Msg
registrationStep model =
    div [ className Background ]
        [ div [ className Login.Styles.Container ]
            [ div [ className StepTitle ]
                [ h1 [] [ text "Cadastro" ]
                , p []
                    [ text "Parece que esse email ainda não está cadastrado, faça seu cadastro para continuar"
                    ]
                ]
            , div [ className StepForm ]
                [ registration model
                ]
            ]
        ]


registration : Model -> Html Msg
registration model =
    form [ onSubmit SubmitRegistration ]
        [ renderErrors model.signUp
        , emailInput model.email UpdateEmail "email" "Email"
        , passwordInput model.password UpdatePassword "password" "Nova Senha"
        , customLoadingOrSubmitButton model.signUp
            [ className Login.Styles.SubmitButton ]
            [ layoutClass DisabledButton ]
            [ text "Cadastrar" ]
        ]
