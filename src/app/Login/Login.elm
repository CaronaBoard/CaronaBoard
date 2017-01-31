module Login.Login exposing (login)

import Html exposing (Html, div, h2, input, text, form)
import Html.Attributes exposing (id, type_, placeholder, value, class, disabled)
import Html.Events exposing (onInput, onSubmit)
import Msg as Root
import Login.Msg exposing (Msg(..))
import Login.Model exposing (Model, Step(..), Response(..), step)


login : Model -> Html Root.Msg
login model =
    div [ id "login" ]
        [ h2 [] [ text "Login" ]
        , form [ onSubmit (Root.MsgForLogin Submit) ] [ stepForm model ]
        ]


stepForm : Model -> Html Root.Msg
stepForm model =
    case step model of
        EmailStep ->
            div []
                [ input
                    [ type_ "email"
                    , placeholder "Email"
                    , onInput (Root.MsgForLogin << UpdateEmail)
                    , value model.email
                    ]
                    []
                , loadingOrSubmitButton "->" model.registered
                ]

        PasswordStep ->
            div [ class "password-step" ]
                [ text model.email
                , input
                    [ type_ "password"
                    , placeholder "Senha"
                    , onInput (Root.MsgForLogin << UpdatePassword)
                    , value model.password
                    ]
                    []
                , loadingOrSubmitButton "Entrar" model.loggedIn
                ]


loadingOrSubmitButton : String -> Response a -> Html Root.Msg
loadingOrSubmitButton buttonText response =
    case response of
        Loading ->
            input [ type_ "submit", value "Carregando...", disabled True ] []

        _ ->
            input [ type_ "submit", value buttonText ] []
