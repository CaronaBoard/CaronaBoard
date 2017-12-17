module RidesRequests.View.New exposing (contactDetails, new)

import Common.Form exposing (loadingOrSubmitButton, renderErrors)
import Html exposing (..)
import Html.Attributes exposing (for, href, id, placeholder, selected, target, value)
import Html.Events exposing (onInput, onSubmit)
import Layout.Styles exposing (Classes(..), layoutClass)
import Profile.Model exposing (Profile, contactDeepLink)
import RemoteData exposing (..)
import Rides.Model
import Rides.Styles exposing (Classes(..), className)
import Rides.View.List exposing (rideInfo, rideRoute)
import RidesRequests.Model exposing (Collection, Msg(..))


new : Rides.Model.Model -> Collection -> Html Msg
new ride collection =
    case collection.new.response of
        Success _ ->
            div [ className Rides.Styles.Card ]
                [ div [ layoutClass CardTitle ] [ text "O pedido de carona foi enviado com sucesso!" ]
                , p [] [ text "Para combinar melhor a carona, use o contato abaixo:" ]
                , contactDetails ride.profile
                ]

        _ ->
            form [ className Rides.Styles.Card, onSubmit (CreateRideRequest ride) ]
                (formFields ride collection)


contactDetails : Profile -> Html msg
contactDetails profile =
    div [ className Contact ]
        [ text <| profile.contact.kind ++ " "
        , a [ href <| contactDeepLink profile.contact, target "_blank" ] [ text profile.contact.value ]
        ]


formFields : Rides.Model.Model -> Collection -> List (Html Msg)
formFields ride collection =
    [ renderErrors collection.new.response
    , div [ layoutClass CardTitle ] [ text "Confirme os detalhes da carona antes de confirmar" ]
    , br [] []
    , rideRoute ride
    , rideInfo ride
    , br [] []
    , loadingOrSubmitButton collection.new.response "submitRideRequest" [ text "Pedir carona" ]
    ]
