module Login.View.Registration exposing (registrationStep)

import Common.CssHelpers exposing (materializeClass)
import Common.Form exposing (loadingOrSubmitButton, renderErrors, textInput)
import Login.Model exposing (Model)
import Login.Msg exposing (Msg(..))
import Login.Styles exposing (Classes(..), class)
import Testable.Html exposing (..)
import Testable.Html.Attributes exposing (autofocus, for, id, placeholder, selected, type_, value)
import Testable.Html.Events exposing (onInput, onSubmit)


registrationStep : Model -> Html Msg
registrationStep model =
    div [ class Background ]
        [ div [ class Container ]
            [ div [ class StepTitle ]
                [ h1 [] [ text "Cadastro" ]
                , p []
                    [ text "Parece que esse email ainda não está cadastrado, faça seu cadastro para continuar"
                    ]
                ]
            , div [ class StepForm ]
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
        , loadingOrSubmitButton model.signUp [ class SubmitButton ] [ text "Cadastrar" ]
        ]
