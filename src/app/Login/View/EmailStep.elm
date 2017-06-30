module Login.View.EmailStep exposing (emailStep)

import Common.CssHelpers exposing (materializeClass)
import Common.Form exposing (loadingOrSubmitButton, renderErrors)
import Common.Icon exposing (icon)
import Login.Model exposing (Model, Msg(UpdateEmail))
import Login.Styles exposing (Classes(SubmitButton), className)
import Html exposing (Html, div, i, input, label, text)
import Html.Attributes exposing (for, id, placeholder, type_, value)
import Html.Events exposing (onInput, onSubmit)


emailStep : Model -> Html Msg
emailStep model =
    div []
        [ renderErrors model.signedIn
        , div [ materializeClass "input-field" ]
            [ input
                [ type_ "email"
                , id "email"
                , onInput UpdateEmail
                , value model.email
                , placeholder " "
                ]
                []
            , label [ for "email" ] [ text "Email" ]
            ]
        , loadingOrSubmitButton model.registered [ className SubmitButton ] [ text "Próximo", icon "arrow_forward" ]
        ]
