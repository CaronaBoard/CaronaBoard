module Rides.View.GiveRide exposing (giveRide)

import Common.CssHelpers exposing (materializeClass)
import Common.Form exposing (loadingOrSubmitButton)
import Common.Response exposing (Response(..))
import Layout.Styles exposing (Classes(..), class)
import Testable.Html exposing (..)
import Testable.Html.Attributes exposing (for, id, placeholder, value)


giveRide : Html a
giveRide =
    div [ materializeClass "container" ]
        [ h1 [ class PageTitle ] [ text "Dar Carona" ]
        , form [ materializeClass "card" ]
            [ div [ materializeClass "card-content" ]
                formFields
            ]
        ]


formFields : List (Html msg)
formFields =
    [ textInput "name" "Seu nome"
    , div [ materializeClass "row" ]
        [ div [ materializeClass "col s12 m12 l6" ]
            [ textInput "origin" "Origem da carona"
            ]
        , div [ materializeClass "col s12 m12 l6" ]
            [ textInput "destination" "Destino da carona (bairro ou referência)"
            ]
        , div [ materializeClass "col s12 m12 l6" ]
            [ textInput "days" "Dias que você pode dar carona"
            ]
        , div [ materializeClass "col s12 m12 l6" ]
            [ textInput "hours" "Horário de saída"
            ]
        ]
    , loadingOrSubmitButton Empty [ class SubmitButton ] [ text "Cadastrar" ]
    ]


textInput : String -> String -> Html msg
textInput id_ label_ =
    div [ materializeClass "input-field" ]
        [ input
            [ id id_
            , value ""
            , placeholder " "
            ]
            []
        , label [ for id_ ] [ text label_ ]
        ]
