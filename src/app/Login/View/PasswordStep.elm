module Login.View.PasswordStep exposing (passwordStep)

import Testable.Html exposing (Html, div, input, text, i)
import Testable.Html.Attributes exposing (class, type_, placeholder, value, autofocus)
import Testable.Html.Events exposing (onInput, onSubmit)
import Login.Msg exposing (Msg(..))
import Login.Model exposing (Model)
import Login.View.Common exposing (loadingOrSubmitButton, renderErrors)


passwordStep : Model -> Html Msg
passwordStep model =
    div [ class "password-step" ]
        [ renderErrors model.loggedIn
        , text model.email
        , input
            [ type_ "password"
            , placeholder "Senha"
            , onInput UpdatePassword
            , value model.password
            , autofocus True
            ]
            []
        , loadingOrSubmitButton
            [ i [ class "material-icons right" ] [ text "done" ]
            , text "Entrar"
            ]
            model.loggedIn
        ]
