module Login.View.Login exposing (login)

import Common.Form exposing (customLoadingOrSubmitButton, emailInput, renderErrors)
import Common.Icon exposing (icon)
import Html exposing (Html, b, div, form, h1, i, input, label, p, text)
import Html.Events exposing (onInput, onSubmit)
import Layout.Styles exposing (Classes(..), layoutClass)
import Login.Model exposing (Model, Msg(..))
import Login.Styles exposing (Classes(..), className)
import Login.View.Layout exposing (formStep)


login : Model -> Html Msg
login model =
    formStep <|
        form [ onSubmit SubmitEmail ]
            [ renderErrors model.signedIn
            , emailInput model.email UpdateEmail "email" "Email"
            , customLoadingOrSubmitButton model.registered
                [ className Login.Styles.SubmitButton ]
                [ layoutClass DisabledButton ]
                [ text "Próximo", icon "arrow_forward" ]
            ]
