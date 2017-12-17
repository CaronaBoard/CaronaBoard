module Groups.View.New exposing (new)

import Common.Form exposing (..)
import Common.Response exposing (..)
import Form exposing (Form)
import Groups.Model exposing (..)
import Html exposing (..)
import Html.Events exposing (onSubmit)
import Layout.Styles exposing (Classes(..), layoutClass)


new : Model -> Html Msg
new model =
    div [ layoutClass Container ]
        [ h1 [ layoutClass PageTitle ] [ text "Criar grupo" ]
        , Html.map FormMsg (formFields model.new)
        ]


formFields : { fields : Form e NewGroup, response : Response a } -> Html Form.Msg
formFields { response, fields } =
    form [ layoutClass Card, onSubmit Form.Submit ]
        [ renderErrors response
        , textInput fields "name" "Nome"
        , loadingOrSubmitButton response "submitNewGroup" [ text "Criar" ]
        ]
