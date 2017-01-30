module Login.Login exposing (login)

import Html exposing (Html, div, h2, input, text)
import Html.Attributes exposing (id, type_, placeholder, value)
import Html.Events exposing (onInput)
import Msg as RootMsg
import Login.Update exposing (Msg(..))
import Login.Model exposing (Model)


login : Model -> Html RootMsg.Msg
login model =
    div [ id "login" ]
        [ h2 [] [ text "Login" ]
        , input [ type_ "email", placeholder "Email", onInput (RootMsg.UpdateLogin << UpdateEmail), value model.email ] []
        , input [ type_ "submit", value "Entrar" ] []
        ]
