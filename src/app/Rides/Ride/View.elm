module Rides.Ride.View exposing (ride)

import Common.CssHelpers exposing (materializeClass)
import Common.Form exposing (loadingOrSubmitButton, renderErrors, textInput)
import Common.IdentifiedList exposing (findById)
import Common.Response as Response exposing (Response(..))
import Html exposing (..)
import Html.Attributes exposing (for, href, id, placeholder, selected, target, value)
import Html.Events exposing (onInput, onSubmit)
import Layout.Styles exposing (Classes(..), layoutClass)
import Model as RootModel
import Profile.Model exposing (contactDeepLink)
import Rides.Model exposing (Msg(..))
import Rides.Ride.Model exposing (Model, Msg(..))
import Rides.Ride.Styles exposing (Classes(..), className)
import Rides.Styles exposing (Classes(Card))
import Rides.View.RidesList exposing (rideInfo, rideRoute)


ridesClass : Rides.Styles.Classes -> Attribute msg
ridesClass =
    Rides.Styles.className


ride : String -> RootModel.Model -> Html Rides.Model.Msg
ride rideId model =
    div [ layoutClass Container ]
        [ h1 [ layoutClass PageTitle ] [ text "Pedir Carona" ]
        , case findById rideId (Response.withDefault [] model.rides.rides) of
            Just ride ->
                Html.map (MsgForRide ride.id) <| rideDetails ride

            Nothing ->
                text "Carona não encontrada"
        ]


rideDetails : Model -> Html Rides.Ride.Model.Msg
rideDetails model =
    case model.rideRequest of
        Success _ ->
            div [ materializeClass "card" ]
                [ div [ materializeClass "card-content" ]
                    [ p [] [ text "O pedido de carona foi enviado com sucesso!" ]
                    , br [] []
                    , p [] [ text "Para combinar melhor com o motorista, use o contato abaixo:" ]
                    , br [] []
                    , p [ className Contact ]
                        [ text <| model.profile.contact.kind ++ " "
                        , a [ href <| contactDeepLink model.profile.contact, target "_blank" ] [ text model.profile.contact.value ]
                        ]
                    ]
                ]

        _ ->
            form [ materializeClass "card", ridesClass Card, onSubmit Submit ]
                [ div [ materializeClass "card-content" ]
                    (formFields model)
                ]


formFields : Model -> List (Html Rides.Ride.Model.Msg)
formFields model =
    [ renderErrors model.rideRequest
    , p [] [ text "Confirme os detalhes da carona antes de confirmar" ]
    , br [] []
    , rideRoute model
    , rideInfo model
    , br [] []
    , loadingOrSubmitButton model.rideRequest [ id "submitRide", layoutClass SubmitButton ] [ text "Pedir carona" ]
    ]
