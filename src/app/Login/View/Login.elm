module Login.View.Login exposing (login)

import Common.Form exposing (renderErrors, customLoadingOrSubmitButton)
import Common.Icon exposing (icon)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, id)
import Html.Styled.Events exposing (onInput, onSubmit)
import Layout.Styles exposing (Classes(..), styledLayoutClass)
import Login.Model exposing (Model, Msg(..))
import Login.Styles
import Login.View.Fields exposing (emailInput)
import Login.View.Layout exposing (formStep)


login : Model -> Html Msg
login model =
    formStep <|
        form [ onSubmit SubmitEmail ]
            [ renderErrors model.signedIn
            , emailInput model.email UpdateEmail "email" "Email"
            , customLoadingOrSubmitButton model.registered
                [ css Login.Styles.submitButton ]
                [ styledLayoutClass DisabledButton ]
                [ text "Próximo", fromUnstyled <| icon "arrow_forward" ]
            ]
