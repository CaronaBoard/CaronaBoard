module Rides.View.New exposing (new)

import Common.Form exposing (..)
import Common.Response exposing (..)
import Form exposing (Form)
import Html exposing (..)
import Html.Events exposing (onInput, onSubmit)
import Layout.Styles exposing (Classes(..), layoutClass)
import Rides.Model exposing (..)


new : String -> Collection -> Html Msg
new groupId model =
    div [ layoutClass Container ]
        [ h1 [ layoutClass PageTitle ] [ text "Dar Carona" ]
        , Html.map (FormMsg groupId) (formFields model.new)
        ]


formFields : { fields : Form e NewRide, response : Response a } -> Html Form.Msg
formFields { response, fields } =
    form [ layoutClass Card, onSubmit Form.Submit ]
        [ renderErrors response
        , formTextInput fields "origin" "Origem da carona"
        , formTextInput fields "destination" "Destino da carona (bairro ou referência)"
        , formTextInput fields "days" "Dias que você pode dar carona"
        , formTextInput fields "hours" "Horário de saída"
        , loadingOrSubmitButton response "submitNewRide" [ text "Cadastrar" ]
        ]
