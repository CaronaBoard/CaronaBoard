module RideRequest.View exposing (rideRequest)

import Common.CssHelpers exposing (materializeClass)
import Common.Form exposing (loadingOrSubmitButton, renderErrors, textInput)
import Common.IdentifiedList exposing (findById)
import Common.Response exposing (Response(..))
import Layout.Styles exposing (Classes(..))
import Model as RootModel
import RideRequest.Model exposing (Model)
import RideRequest.Msg exposing (Msg(..))
import RideRequest.Styles exposing (Classes(..), class)
import Rides.Model exposing (contactDeepLink, contactIdentifier)
import Testable.Html exposing (..)
import Testable.Html.Attributes exposing (for, href, id, placeholder, selected, target, value)
import Testable.Html.Events exposing (onInput, onSubmit)


layoutClass : class -> Attribute msg
layoutClass =
    Layout.Styles.class


rideRequest : String -> RootModel.Model -> Html Msg
rideRequest rideId model =
    div [ materializeClass "container" ]
        [ h1 [ layoutClass PageTitle ] [ text "Pedir Carona" ]
        , case ( findById rideId model.rides, model.rideRequest.response ) of
            ( Just ride, Success _ ) ->
                div [ materializeClass "card" ]
                    [ div [ materializeClass "card-content" ]
                        [ p [] [ text "O pedido de carona foi enviado com sucesso!" ]
                        , br [] []
                        , p [] [ text "Para combinar melhor com o motorista, use o contato abaixo:" ]
                        , br [] []
                        , p [ class Contact ]
                            [ text <| ride.contact.kind ++ " "
                            , a [ href <| contactDeepLink ride.contact, target "_blank" ] [ text ride.contact.value ]
                            ]
                        ]
                    ]

            ( Just ride, _ ) ->
                form [ materializeClass "card", onSubmit (Submit ride) ]
                    [ div [ materializeClass "card-content" ]
                        (formFields model.rideRequest)
                    ]

            ( Nothing, _ ) ->
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
            [ textInput model.fields.contact.value UpdateContactValue "contactValue" (contactIdentifier model.fields.contact.kind)
            ]
        ]
    , loadingOrSubmitButton model.response [ id "submitRideRequest", layoutClass SubmitButton ] [ text "Pedir carona" ]
    ]


contactTypeOption : Model -> String -> Html msg
contactTypeOption model value_ =
    option [ value value_, selected (model.fields.contact.value == value_) ] [ text value_ ]
