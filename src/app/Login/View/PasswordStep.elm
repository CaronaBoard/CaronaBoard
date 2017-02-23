module Login.View.PasswordStep exposing (passwordStep)

import Testable.Html exposing (Html, div, input, text, i, label)
import Testable.Html.Attributes exposing (class, id, type_, for, placeholder, value, autofocus)
import Testable.Html.Events exposing (onInput, onSubmit)
import Login.Msg exposing (Msg(..))
import Login.Model exposing (Model)
import Common.Form exposing (loadingOrSubmitButton, renderErrors)
import Common.Icon exposing (iconRight)


passwordStep : Model -> Html Msg
passwordStep model =
    div [ class "password-step" ]
        [ renderErrors model.loggedIn
        , text model.email
        , div [ class "input-field" ]
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
        , loadingOrSubmitButton
            [ iconRight "done"
            , text "Entrar"
            ]
            model.loggedIn
        ]
