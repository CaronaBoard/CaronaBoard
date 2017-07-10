module Rides.View.Details exposing (contactDetails, details)

import Common.Form exposing (loadingOrSubmitButton, renderErrors, textInput)
import Common.IdentifiedList exposing (findById)
import Common.Response as Response exposing (Response(..))
import Html exposing (..)
import Html.Attributes exposing (for, href, id, placeholder, selected, target, value)
import Html.Events exposing (onInput, onSubmit)
import Layout.Styles exposing (Classes(..), layoutClass)
import Model as RootModel
import Profile.Model exposing (Profile, contactDeepLink)
import Rides.Model exposing (Model, Msg(..))
import Rides.Styles exposing (Classes(..), className)
import Rides.View.List exposing (rideInfo, rideRoute)


details : String -> String -> RootModel.Model -> Html Rides.Model.Msg
details groupId rideId model =
    div [ layoutClass Container ]
        [ h1 [ layoutClass PageTitle ] [ text "Pedir Carona" ]
        , case findById rideId (Response.withDefault [] model.rides.list) of
            Just ride ->
                rideDetails groupId rideId ride

            Nothing ->
                text "Carona não encontrada"
        ]


rideDetails : String -> String -> Model -> Html Rides.Model.Msg
rideDetails groupId rideId model =
    case model.rideRequest of
        Success _ ->
            div [ className Rides.Styles.Card ]
                [ div [ layoutClass CardTitle ] [ text "O pedido de carona foi enviado com sucesso!" ]
                , p [] [ text "Para combinar melhor a carona, use o contato abaixo:" ]
                , contactDetails model.profile
                ]

        _ ->
            form [ className Rides.Styles.Card, onSubmit (Submit rideId groupId) ]
                (formFields model)


contactDetails : Profile -> Html msg
contactDetails profile =
    div [ className Contact ]
        [ text <| profile.contact.kind ++ " "
        , a [ href <| contactDeepLink profile.contact, target "_blank" ] [ text profile.contact.value ]
        ]


formFields : Model -> List (Html Rides.Model.Msg)
formFields model =
    [ renderErrors model.rideRequest
    , div [ layoutClass CardTitle ] [ text "Confirme os detalhes da carona antes de confirmar" ]
    , br [] []
    , rideRoute model
    , rideInfo model
    , br [] []
    , loadingOrSubmitButton model.rideRequest "submitRide" [ text "Pedir carona" ]
    ]
