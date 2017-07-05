module GiveRide.View exposing (giveRide)

import Common.CssHelpers exposing (materializeClass)
import Common.Form exposing (loadingOrSubmitButton, renderErrors, textInput)
import GiveRide.Model exposing (Model, Msg(..))
import Html exposing (..)
import Html.Attributes exposing (for, id, placeholder, selected, value)
import Html.Events exposing (onInput, onSubmit)
import Layout.Styles exposing (Classes(..), layoutClass)


giveRide : String -> Model -> Html Msg
giveRide groupId model =
    div [ layoutClass Container ]
        [ h1 [ layoutClass PageTitle ] [ text "Dar Carona" ]
        , form [ materializeClass "card", onSubmit (Submit groupId) ]
            [ div [ materializeClass "card-content" ]
                (formFields model)
            ]
        ]


formFields : Model -> List (Html Msg)
formFields model =
    [ renderErrors model.response
    , div [ materializeClass "row" ]
        [ div [ materializeClass "col s12 m12 l6" ]
            [ textInput model.fields.origin UpdateOrigin "origin" "Origem da carona"
            ]
        , div [ materializeClass "col s12 m12 l6" ]
            [ textInput model.fields.destination UpdateDestination "destination" "Destino da carona (bairro ou referência)"
            ]
        , div [ materializeClass "col s12 m12 l6" ]
            [ textInput model.fields.days UpdateDays "days" "Dias que você pode dar carona"
            ]
        , div [ materializeClass "col s12 m12 l6" ]
            [ textInput model.fields.hours UpdateHours "hours" "Horário de saída"
            ]
        ]
    , loadingOrSubmitButton model.response [ id "submitNewRide", layoutClass SubmitButton ] [ text "Cadastrar" ]
    ]
