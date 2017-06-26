module Login.View.Login exposing (login)

import Common.Icon exposing (icon)
import Login.Model exposing (Model, Step(..), step)
import Login.Msg exposing (Msg(..))
import Login.Styles exposing (Classes(..), class)
import Login.View.EmailStep exposing (emailStep)
import Login.View.PasswordStep exposing (passwordStep)
import Login.View.Registration exposing (registrationStep)
import Testable.Html exposing (Html, b, div, form, h1, input, p, text)
import Testable.Html.Events exposing (onInput, onSubmit)


login : Model -> Html Msg
login model =
    case step model of
        EmailStep ->
            formStep (emailStep model)

        Login.Model.PasswordStep ->
            formStep (passwordStep model)

        NotRegisteredStep ->
            registrationStep model


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
                ]
            ]
        ]
