module Rides.RideRequest.View exposing (rideRequest)

import Common.CssHelpers exposing (materializeClass)
import Common.Form exposing (loadingOrSubmitButton, renderErrors, textInput)
import Common.IdentifiedList exposing (findById)
import Common.Response exposing (Response(..))
import Layout.Styles exposing (Classes(..))
import Model as RootModel
import Profile.Model exposing (contactDeepLink)
import Rides.Model exposing (Ride)
import Rides.Msg exposing (..)
import Rides.RideRequest.Model exposing (Model)
import Rides.RideRequest.Msg exposing (Msg(..))
import Rides.RideRequest.Styles exposing (Classes(..), class)
import Rides.Styles exposing (Classes(Card))
import Rides.View.RidesList exposing (rideInfo, rideRoute)
import Testable.Html exposing (..)
import Testable.Html.Attributes exposing (for, href, id, placeholder, selected, target, value)
import Testable.Html.Events exposing (onInput, onSubmit)


layoutClass : class -> Attribute msg
layoutClass =
    Layout.Styles.class


ridesClass : class -> Attribute msg
ridesClass =
    Rides.Styles.class


rideRequest : String -> RootModel.Model -> Html Rides.Msg.Msg
rideRequest rideId model =
    div [ materializeClass "container" ]
        [ h1 [ layoutClass PageTitle ] [ text "Pedir Carona" ]
        , case findById rideId model.rides of
            Just ride ->
                Testable.Html.map (MsgForRideRequest ride.id) <| rideRequestDetails ride

            Nothing ->
                text "Carona não encontrada"
        ]


rideRequestDetails : Ride -> Html Rides.RideRequest.Msg.Msg
rideRequestDetails ride =
    case ride.rideRequest.response of
        Success _ ->
            div [ materializeClass "card" ]
                [ div [ materializeClass "card-content" ]
                    [ p [] [ text "O pedido de carona foi enviado com sucesso!" ]
                    , br [] []
                    , p [] [ text "Para combinar melhor com o motorista, use o contato abaixo:" ]
                    , br [] []
                    , p [ class Contact ]
                        [ text <| ride.profile.contact.kind ++ " "
                        , a [ href <| contactDeepLink ride.profile.contact, target "_blank" ] [ text ride.profile.contact.value ]
                        ]
                    ]
                ]

        _ ->
            form [ materializeClass "card", ridesClass Card, onSubmit (Submit ride) ]
                [ div [ materializeClass "card-content" ]
                    (formFields ride ride.rideRequest)
                ]


formFields : Ride -> Model -> List (Html Rides.RideRequest.Msg.Msg)
formFields ride model =
    [ renderErrors model.response
    , p [] [ text "Confirme os detalhes da carona antes de confirmar" ]
    , br [] []
    , rideRoute ride
    , rideInfo ride
    , br [] []
    , loadingOrSubmitButton model.response [ id "submitRideRequest", layoutClass SubmitButton ] [ text "Pedir carona" ]
    ]
