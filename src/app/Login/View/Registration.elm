module Login.View.Registration exposing (registration)

import Common.CssHelpers exposing (materializeClass)
import Common.Form exposing (loadingOrSubmitButton, renderErrors, textInput)
import Login.Model exposing (Model)
import Login.Msg exposing (Msg(..))
import Login.Styles exposing (Classes(..), class)
import Testable.Html exposing (..)
import Testable.Html.Attributes exposing (autofocus, for, id, placeholder, type_, value)
import Testable.Html.Events exposing (onInput, onSubmit)


registration : Model -> Html Msg
registration model =
    div []
        [ div [ materializeClass "input-field" ]
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
        , loadingOrSubmitButton model.registered [ class SubmitButton ] [ text "Cadastrar" ]
        ]
