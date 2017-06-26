module RideRequest.View exposing (rideRequest)

import Common.CssHelpers exposing (materializeClass)
import Common.Form exposing (loadingOrSubmitButton, renderErrors, textInput)
import Common.IdentifiedList exposing (findById)
import Common.Response exposing (Response(..))
import Layout.Styles exposing (Classes(..))
import Model as RootModel
import Profile.Model exposing (contactDeepLink)
import RideRequest.Model exposing (Model)
import RideRequest.Msg exposing (Msg(..))
import RideRequest.Styles exposing (Classes(..), class)
import Rides.Model exposing (Ride)
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
                form [ materializeClass "card", ridesClass Card, onSubmit (Submit ride) ]
                    [ div [ materializeClass "card-content" ]
                        (formFields ride model.rideRequest)
                    ]

            ( Nothing, _ ) ->
                text "Carona não encontrada"
        ]


formFields : Ride -> Model -> List (Html Msg)
formFields ride model =
    [ renderErrors model.response
    , p [] [ text "Confirme os detalhes da carona antes de confirmar" ]
    , br [] []
    , rideRoute ride
    , rideInfo ride
    , br [] []
    , loadingOrSubmitButton model.response [ id "submitRideRequest", layoutClass SubmitButton ] [ text "Pedir carona" ]
    ]
