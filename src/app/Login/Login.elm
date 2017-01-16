module Login.Login exposing (login)

import Html exposing (Html, div, h2, input, text)
import Html.Attributes exposing (id, type_, placeholder, value)


login : Html a
login =
    div [ id "login" ]
        [ h2 [] [ text "Login" ]
        , input [ type_ "text", placeholder "Email" ] []
        , input [ type_ "password", placeholder "Senha" ] []
        , input [ type_ "submit", value "Entrar" ] []
        ]
