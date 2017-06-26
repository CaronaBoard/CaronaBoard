module RideRequest.View exposing (rideRequest)

import Common.CssHelpers exposing (materializeClass)
import Common.Form exposing (loadingOrSubmitButton, renderErrors)
import Common.IdentifiedList exposing (findById)
import Layout.Styles exposing (Classes(..), class)
import Model as RootModel
import RideRequest.Model exposing (Model)
import RideRequest.Msg exposing (Msg(..))
import Testable.Html exposing (..)
import Testable.Html.Attributes exposing (for, id, placeholder, selected, value)
import Testable.Html.Events exposing (onInput, onSubmit)


rideRequest : String -> RootModel.Model -> Html Msg
rideRequest rideId model =
    div [ materializeClass "container" ]
        [ h1 [ class PageTitle ] [ text "Pedir Carona" ]
        , case findById rideId model.rides of
            Just ride ->
                form [ materializeClass "card", onSubmit (Submit ride) ]
                    [ div [ materializeClass "card-content" ]
                        (formFields model.rideRequest)
                    ]

            Nothing ->
                text "Carona não encontrada"
        ]


formFields : Model -> List (Html Msg)
formFields model =
    [ renderErrors model.response
    , text "Confirme seus dados para pedir carona"
    , textInput model.fields.name UpdateName "name" "Seu nome"
    , div [ materializeClass "row" ]
        [ div [ materializeClass "col s5" ]
            [ div [ materializeClass "input-field" ]
                [ select [ materializeClass "browser-default", onInput UpdateContactType, id "contactType" ]
                    [ contactTypeOption model "Whatsapp"
                    , contactTypeOption model "Telegram"
                    ]
                , label [ for "contactType" ] [ text "Contato" ]
                ]
            ]
        , div [ materializeClass "col s7" ]
            [ textInput model.fields.contactValue UpdateContactValue "contactValue" (contactIdentifier model.fields.contactType)
            ]
        ]
    , loadingOrSubmitButton model.response [ id "submitRideRequest", class SubmitButton ] [ text "Pedir carona" ]
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


contactTypeOption : Model -> String -> Html msg
contactTypeOption model value_ =
    option [ value value_, selected (model.fields.contactType == value_) ] [ text value_ ]


contactIdentifier : String -> String
contactIdentifier contactType =
    if contactType == "Telegram" then
        "Nick"
    else
        "Número"
