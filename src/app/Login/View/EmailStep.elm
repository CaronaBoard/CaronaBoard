module Login.View.EmailStep exposing (emailStep)

import Common.Form exposing (customLoadingOrSubmitButton, emailInput, renderErrors)
import Common.Icon exposing (icon)
import Html exposing (Html, div, i, input, label, text)
import Layout.Styles exposing (Classes(..), layoutClass)
import Login.Model exposing (Model, Msg(UpdateEmail))
import Login.Styles exposing (Classes(SubmitButton), className)


emailStep : Model -> Html Msg
emailStep model =
    div []
        [ renderErrors model.signedIn
        , emailInput model.email UpdateEmail "email" "Email"
        , customLoadingOrSubmitButton model.registered
            [ className Login.Styles.SubmitButton ]
            [ layoutClass DisabledButton ]
            [ text "Próximo", icon "arrow_forward" ]
        ]
