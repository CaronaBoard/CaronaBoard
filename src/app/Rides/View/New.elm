module Rides.View.New exposing (new)

import Common.Form exposing (..)
import Common.Response exposing (..)
import Form exposing (Form)
import Html.Styled exposing (..)
import Html.Styled.Events exposing (onInput, onSubmit)
import Layout.Styles exposing (Classes(..), styledLayoutClass)
import Rides.Model exposing (..)


new : String -> Collection -> Html Msg
new groupId model =
    div [ styledLayoutClass Container ]
        [ h1 [ styledLayoutClass PageTitle ] [ text "Dar Carona" ]
        , Html.Styled.map (FormMsg groupId) (formFields model.new)
        ]


formFields : { fields : Form e NewRide, response : Response a } -> Html Form.Msg
formFields { response, fields } =
    form [ styledLayoutClass Card, onSubmit Form.Submit ]
        [ fromUnstyled <| renderErrors response
        , fromUnstyled <| textInput fields "origin" "Origem da carona"
        , fromUnstyled <| textInput fields "destination" "Destino da carona (bairro ou referência)"
        , fromUnstyled <| textInput fields "days" "Dias que você pode dar carona"
        , fromUnstyled <| textInput fields "hours" "Horário de saída"
        , styledLoadingOrSubmitButton response "submitNewRide" [ text "Cadastrar" ]
        ]
