module Login.Login exposing (login)

import Html exposing (Html, div, h2, input, text, form)
import Html.Attributes exposing (id, type_, placeholder, value, class, disabled)
import Html.Events exposing (onInput, onSubmit)
import Update as Root
import Login.Update exposing (Msg(..))
import Login.Model exposing (Model, Step(..), User(..))


login : Model -> Html Root.Msg
login model =
    div [ id "login" ]
        [ h2 [] [ text "Login" ]
        , form [ onSubmit (Root.UpdateLogin Submit) ] [ step model ]
        ]


step : Model -> Html Root.Msg
step model =
    case model.step of
        EmailStep ->
            div []
                [ input
                    [ type_ "email"
                    , placeholder "Email"
                    , onInput (Root.UpdateLogin << UpdateEmail)
                    , value model.email
                    ]
                    []
                , input [ type_ "submit", value "->" ] []
                ]

        PasswordStep ->
            div [ class "password-step" ]
                [ text model.email
                , input
                    [ type_ "password"
                    , placeholder "Senha"
                    , onInput (Root.UpdateLogin << UpdatePassword)
                    , value model.password
                    ]
                    []
                , loadingOrSubmitButton model
                ]


loadingOrSubmitButton : Model -> Html Root.Msg
loadingOrSubmitButton model =
    case model.user of
        Loading ->
            input [ type_ "submit", value "Carregando...", disabled True ] []

        _ ->
            input [ type_ "submit", value "Entrar" ] []
