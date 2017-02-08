module Login.View.EmailStep exposing (emailStep)

import Testable.Html exposing (Html, div, input, label, text)
import Testable.Html.Attributes exposing (type_, placeholder, value, class, id, for)
import Testable.Html.Events exposing (onInput, onSubmit)
import Login.Msg exposing (Msg(..))
import Login.Model exposing (Model)
import Login.View.Common exposing (loadingOrSubmitButton, renderErrors)


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
                ]
                []
            , label [ for "email" ] [ text "Email" ]
            ]
        , loadingOrSubmitButton "->" model.registered
        ]
