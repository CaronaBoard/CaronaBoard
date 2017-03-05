module Login.View.EmailStep exposing (emailStep)

import Testable.Html exposing (Html, div, input, label, text, i)
import Testable.Html.Attributes exposing (type_, placeholder, value, class, id, for)
import Testable.Html.Events exposing (onInput, onSubmit)
import Login.Msg exposing (Msg(UpdateEmail))
import Login.Model exposing (Model)
import Common.Form exposing (loadingOrSubmitButton, renderErrors)
import Common.Icon exposing (icon)
import Login.Styles exposing (scopedClass, Classes(Button, SubmitButton))


emailStep : Model -> Html Msg
emailStep model =
    div []
        [ renderErrors model.loggedIn
        , div [ class "input-field" ]
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
        , loadingOrSubmitButton model.registered [ scopedClass [ Button, SubmitButton ] ] [ text "Próximo", icon "arrow_forward" ]
        ]
