module Login.View.Registration exposing (registrationStep)

import Common.CssHelpers exposing (materializeClass)
import Common.Form exposing (customLoadingOrSubmitButton, renderErrors, textInput)
import Html exposing (..)
import Html.Attributes exposing (autofocus, for, id, placeholder, selected, type_, value)
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
                [ form [ onSubmit Submit ] [ registration model ]
                ]
            ]
        ]


registration : Model -> Html Msg
registration model =
    div []
        [ renderErrors model.signUp
        , div [ materializeClass "input-field" ]
            [ input
                [ type_ "email"
                , id "email"
                , onInput UpdateEmail
                , value model.email
                , placeholder " "
                ]
                []
            , label [ for "email" ] [ text "Email" ]
            ]
        , div [ materializeClass "input-field" ]
            [ input
                [ type_ "password"
                , id "password"
                , onInput UpdatePassword
                , value model.password
                , placeholder " "
                ]
                []
            , label [ for "password" ] [ text "Nova Senha" ]
            ]
        , customLoadingOrSubmitButton model.signUp
            [ className Login.Styles.SubmitButton ]
            [ layoutClass DisabledButton ]
            [ text "Cadastrar" ]
        ]
