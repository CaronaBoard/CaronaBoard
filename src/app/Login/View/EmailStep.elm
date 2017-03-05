module Login.View.EmailStep exposing (emailStep)

import Testable.Html exposing (Html, div, input, label, text, i)
import Testable.Html.Attributes exposing (type_, placeholder, value, id, for)
import Testable.Html.Events exposing (onInput, onSubmit)
import Login.Msg exposing (Msg(UpdateEmail))
import Login.Model exposing (Model)
import Common.Form exposing (loadingOrSubmitButton, renderErrors)
import Common.Icon exposing (icon)
import Login.Styles exposing (classes, Classes(Button, SubmitButton))
import Common.CssHelpers exposing (materializeClass)


emailStep : Model -> Html Msg
emailStep model =
    div []
        [ renderErrors model.loggedIn
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
        , loadingOrSubmitButton model.registered [ classes [ Button, SubmitButton ] ] [ text "Próximo", icon "arrow_forward" ]
        ]
