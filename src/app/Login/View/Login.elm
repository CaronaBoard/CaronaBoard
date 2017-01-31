module Login.View.Login exposing (login)

import Html exposing (Html, div, h2, input, text, form)
import Html.Attributes exposing (id, type_, placeholder, value, class, disabled)
import Html.Events exposing (onInput, onSubmit)
import Msg as Root
import Login.Msg exposing (Msg(..))
import Login.Model exposing (Model, Step(..), Response(..), step)
import Login.View.EmailStep exposing (emailStep)
import Login.View.PasswordStep exposing (passwordStep)


login : Model -> Html Root.Msg
login model =
    div [ id "login" ]
        [ stepForm model ]


stepForm : Model -> Html Root.Msg
stepForm model =
    case step model of
        EmailStep ->
            formStep (emailStep model)

        PasswordStep ->
            formStep (passwordStep model)

        NotRegisteredStep ->
            div []
                [ text "O CaronaBoard está em fase de testes, seja o primeiro a saber quando for lançado" ]


formStep : Html Root.Msg -> Html Root.Msg
formStep step =
    div []
        [ h2 [] [ text "Login" ]
        , form [ onSubmit (Root.MsgForLogin Submit) ] [ step ]
        ]
