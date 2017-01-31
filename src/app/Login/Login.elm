module Login.Login exposing (login)

import Html exposing (Html, div, h2, input, text, form)
import Html.Attributes exposing (id, type_, placeholder, value)
import Html.Events exposing (onInput, onSubmit)
import Msg as RootMsg
import Login.Update exposing (Msg(..))
import Login.Model exposing (Model, Step(..))


login : Model -> Html RootMsg.Msg
login model =
    div [ id "login" ]
        [ h2 [] [ text "Login" ]
        , form [ onSubmit (RootMsg.UpdateLogin Submit) ] [ step model ]
        ]


step : Model -> Html RootMsg.Msg
step model =
    case model.step of
        EmailStep ->
            div []
                [ input [ type_ "email", placeholder "Email", onInput (RootMsg.UpdateLogin << UpdateEmail), value model.email ] []
                , input [ type_ "submit", value "->" ] []
                ]

        PasswordStep ->
            div []
                [ input [ type_ "password", placeholder "Senha", onInput (RootMsg.UpdateLogin << UpdateEmail), value model.email ] []
                , input [ type_ "submit", value "Entrar" ] []
                ]
