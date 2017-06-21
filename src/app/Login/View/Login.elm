module Login.View.Login exposing (login)

import Common.Icon exposing (icon)
import Login.Model exposing (Model, Step(..), step)
import Login.Msg exposing (Msg(..))
import Login.Styles exposing (Classes(Background, Container, Icon, StepForm, StepTitle), class)
import Login.View.EmailStep exposing (emailStep)
import Login.View.PasswordStep exposing (passwordStep)
import Testable.Html exposing (Html, b, div, form, h1, input, p, text)
import Testable.Html.Events exposing (onInput, onSubmit)


login : Model -> Html Msg
login model =
    case step model of
        EmailStep ->
            formStep (emailStep model)

        PasswordStep ->
            formStep (passwordStep model)

        NotRegisteredStep ->
            div []
                [ text "Seu email não está cadastrado. Ainda estamos em fase beta, novos cadastros serão aceitos em breve" ]


formStep : Html Msg -> Html Msg
formStep step =
    div [ class Background ]
        [ div
            [ class Container ]
            [ div [ class StepTitle ]
                [ h1 []
                    [ b [] [ text "Carona" ]
                    , text "Board"
                    ]
                , p []
                    [ text "O CaronaBoard é um aplicativo de grupos de caronas, descubra quem está indo para o mesmo lugar que você e dê ou peça uma carona"
                    ]
                ]
            , div [ class StepForm ]
                [ div [ class Icon ]
                    [ div [] [ icon "lock_outline" ]
                    , text "Entre com sua conta"
                    ]
                , form [ onSubmit Submit ] [ step ]
                , div [] [ text "Ainda estamos em fase beta, novos cadastros serão aceitos em breve" ]
                ]
            ]
        ]
