module Login.View.Login exposing (login)

import Common.Form exposing (customLoadingOrSubmitButton, renderErrors)
import Common.Icon exposing (icon)
import Html.Styled exposing (..)
import Html.Styled.Events exposing (onInput, onSubmit)
import Layout.Styles exposing (..)
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
            , customLoadingOrSubmitButton
                { response = model.registered
                , id = "submitEmail"
                , enabledStyle = Login.Styles.submitButton
                , disabledStyle = disabledButton
                }
                []
                [ text "Próximo", icon "arrow_forward" ]
            ]
