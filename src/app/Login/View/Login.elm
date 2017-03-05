module Login.View.Login exposing (login)

import Testable.Html exposing (Html, div, h1, b, p, input, text, form)
import Testable.Html.Events exposing (onInput, onSubmit)
import Login.Msg exposing (Msg(..))
import Login.Model exposing (Model, Step(..), step)
import Login.View.EmailStep exposing (emailStep)
import Login.View.PasswordStep exposing (passwordStep)
import Common.Icon exposing (icon)
import Login.Styles exposing (scopedClass, Classes(Background, Container, Step, StepTitle, StepForm, Icon))


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
    div [ scopedClass [ Background ] ]
        [ div
            [ scopedClass [ Container ] ]
            [ div [ scopedClass [ Step, StepTitle ] ]
                [ h1 []
                    [ b [] [ text "Carona" ]
                    , text "Board"
                    ]
                , p []
                    [ text "O CaronaBoard é um aplicativo de grupos de caronas, descubra quem está indo para o mesmo lugar que você e dê ou peça uma carona"
                    ]
                ]
            , div [ scopedClass [ Step, StepForm ] ]
                [ div [ scopedClass [ Icon ] ]
                    [ div [] [ icon "lock_outline" ]
                    , text "Entre com sua conta"
                    ]
                , form [ onSubmit Submit ] [ step ]
                , div [] [ text "Ainda estamos em fase beta, novos cadastros serão aceitos em breve" ]
                ]
            ]
        ]
