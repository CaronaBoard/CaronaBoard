module Groups.View.New exposing (new)

import Common.Form exposing (..)
import Common.Response exposing (..)
import Form exposing (Form)
import Groups.Model exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Events exposing (onSubmit)
import Layout.Styles exposing (..)


new : Model -> Html Msg
new model =
    styled div
        container
        []
        [ pageTitle [] [ text "Criar grupo" ]
        , Html.Styled.map FormMsg (formFields model.new)
        ]


formFields : { fields : Form e NewGroup, response : Response a } -> Html Form.Msg
formFields { response, fields } =
    styled form
        card
        [ onSubmit Form.Submit ]
        [ renderErrors response
        , textInput fields "name" "Nome"
        , loadingOrSubmitButton response "submitNewGroup" [ text "Criar" ]
        ]
