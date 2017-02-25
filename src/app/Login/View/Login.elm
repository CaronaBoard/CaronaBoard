module Login.View.Login exposing (login)

import Testable.Html exposing (Html, div, h1, b, p, input, text, form)
import Testable.Html.Events exposing (onInput, onSubmit)
import Testable.Html.Attributes exposing (class)
import Login.Msg exposing (Msg(..))
import Login.Model exposing (Model, Step(..), step)
import Login.View.EmailStep exposing (emailStep)
import Login.View.PasswordStep exposing (passwordStep)


login : Model -> Html Msg
login model =
    case step model of
        EmailStep ->
            formStep (emailStep model)

        PasswordStep ->
            formStep (passwordStep model)

        NotRegisteredStep ->
            div []
                [ text "O CaronaBoard está em fase de testes, seja o primeiro a saber quando for lançado" ]


formStep : Html Msg -> Html Msg
formStep step =
    div [ class "login-container" ]
        [ div []
            [ h1 []
                [ b [] [ text "Carona" ]
                , text "Board"
                ]
            , p []
                [ text "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                ]
            ]
        , form [ onSubmit Submit ] [ step ]
        , div []
            [ text "Ainda estamos em fase beta, novos cadastros serão aceitos em breve"
            ]
        ]
