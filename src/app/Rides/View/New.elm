module Rides.View.New exposing (new)

import Common.Form exposing (loadingOrSubmitButton, renderErrors, textInput)
import Html exposing (..)
import Html.Events exposing (onInput, onSubmit)
import Layout.Styles exposing (Classes(..), layoutClass)
import Rides.Model exposing (Collection, Msg(..))


new : String -> Collection -> Html Msg
new groupId model =
    div [ layoutClass Container ]
        [ h1 [ layoutClass PageTitle ] [ text "Dar Carona" ]
        , form [ layoutClass Card, onSubmit (CreateRide groupId) ]
            (formFields model)
        ]


formFields : Collection -> List (Html Msg)
formFields { new } =
    [ renderErrors new.response
    , textInput new.fields.origin UpdateOrigin "origin" "Origem da carona"
    , textInput new.fields.destination UpdateDestination "destination" "Destino da carona (bairro ou referência)"
    , textInput new.fields.days UpdateDays "days" "Dias que você pode dar carona"
    , textInput new.fields.hours UpdateHours "hours" "Horário de saída"
    , loadingOrSubmitButton new.response "submitNewRide" [ text "Cadastrar" ]
    ]
