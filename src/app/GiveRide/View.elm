module GiveRide.View exposing (giveRide)

import Common.CssHelpers exposing (materializeClass)
import Common.Form exposing (loadingOrSubmitButton)
import Common.Response exposing (Response(..))
import GiveRide.Model exposing (Model)
import GiveRide.Msg exposing (Msg(..))
import Layout.Styles exposing (Classes(..), class)
import Testable.Html exposing (..)
import Testable.Html.Attributes exposing (for, id, placeholder, value)
import Testable.Html.Events exposing (onInput)


giveRide : Model -> Html Msg
giveRide model =
    div [ materializeClass "container" ]
        [ h1 [ class PageTitle ] [ text "Dar Carona" ]
        , form [ materializeClass "card" ]
            [ div [ materializeClass "card-content" ]
                (formFields model)
            ]
        ]


formFields : Model -> List (Html Msg)
formFields model =
    [ textInput model.name UpdateName "name" "Seu nome"
    , div [ materializeClass "row" ]
        [ div [ materializeClass "col s12 m12 l6" ]
            [ textInput model.origin UpdateOrigin "origin" "Origem da carona"
            ]
        , div [ materializeClass "col s12 m12 l6" ]
            [ textInput model.destination UpdateDestination "destination" "Destino da carona (bairro ou referência)"
            ]
        , div [ materializeClass "col s12 m12 l6" ]
            [ textInput model.days UpdateDays "days" "Dias que você pode dar carona"
            ]
        , div [ materializeClass "col s12 m12 l6" ]
            [ textInput model.hours UpdateHours "hours" "Horário de saída"
            ]
        ]
    , loadingOrSubmitButton Empty [ id "submitNewRide", class SubmitButton ] [ text "Cadastrar" ]
    ]


textInput : String -> (String -> Msg) -> String -> String -> Html Msg
textInput value_ msg id_ label_ =
    div [ materializeClass "input-field" ]
        [ input
            [ id id_
            , value value_
            , placeholder " "
            , onInput msg
            ]
            []
        , label [ for id_ ] [ text label_ ]
        ]
