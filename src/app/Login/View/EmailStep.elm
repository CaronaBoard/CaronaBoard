module Login.View.EmailStep exposing (emailStep)

import Testable.Html exposing (Html, div, input)
import Testable.Html.Attributes exposing (type_, placeholder, value, class)
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
                , placeholder "Email"
                , onInput UpdateEmail
                , value model.email
                ]
                []
            ]
        , loadingOrSubmitButton "->" model.registered
        ]
