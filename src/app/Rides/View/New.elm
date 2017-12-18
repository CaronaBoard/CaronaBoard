module Rides.View.New exposing (new)

import Common.Form exposing (..)
import Common.Response exposing (..)
import Form exposing (Form)
import Html.Styled exposing (..)
import Html.Styled.Events exposing (onInput, onSubmit)
import Layout.Styles exposing (Classes(..), layoutClass)
import Rides.Model exposing (..)


new : String -> Collection -> Html Msg
new groupId model =
    div [ layoutClass Container ]
        [ h1 [ layoutClass PageTitle ] [ text "Dar Carona" ]
        , Html.Styled.map (FormMsg groupId) (formFields model.new)
        ]


formFields : { fields : Form e NewRide, response : Response a } -> Html Form.Msg
formFields { response, fields } =
    form [ layoutClass Card, onSubmit Form.Submit ]
        [ renderErrors response
        , textInput fields "origin" "Origem da carona"
        , textInput fields "destination" "Destino da carona (bairro ou referência)"
        , textInput fields "days" "Dias que você pode dar carona"
        , textInput fields "hours" "Horário de saída"
        , loadingOrSubmitButton response "submitNewRide" [ text "Cadastrar" ]
        ]
