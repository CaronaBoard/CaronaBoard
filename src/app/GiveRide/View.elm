module GiveRide.View exposing (giveRide)

import Common.Form exposing (loadingOrSubmitButton, renderErrors, textInput)
import GiveRide.Model exposing (Model, Msg(..))
import Html exposing (..)
import Html.Events exposing (onInput, onSubmit)
import Layout.Styles exposing (Classes(..), layoutClass)


giveRide : String -> Model -> Html Msg
giveRide groupId model =
    div [ layoutClass Container ]
        [ h1 [ layoutClass PageTitle ] [ text "Dar Carona" ]
        , form [ layoutClass Card, onSubmit (Submit groupId) ]
            (formFields model)
        ]


formFields : Model -> List (Html Msg)
formFields model =
    [ renderErrors model.response
    , textInput model.fields.origin UpdateOrigin "origin" "Origem da carona"
    , textInput model.fields.destination UpdateDestination "destination" "Destino da carona (bairro ou referência)"
    , textInput model.fields.days UpdateDays "days" "Dias que você pode dar carona"
    , textInput model.fields.hours UpdateHours "hours" "Horário de saída"
    , loadingOrSubmitButton model.response "submitNewRide" [ text "Cadastrar" ]
    ]
