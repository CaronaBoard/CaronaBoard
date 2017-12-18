module RidesRequests.View.New exposing (contactDetails, new)

import Common.Form exposing (loadingOrSubmitButton, renderErrors)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (for, href, id, placeholder, selected, target, value)
import Html.Styled.Events exposing (onInput, onSubmit)
import Layout.Styles exposing (..)
import Profile.Model exposing (Profile, contactDeepLink)
import RemoteData exposing (..)
import Rides.Model
import Rides.Styles exposing (..)
import Rides.View.List exposing (rideInfo, rideRoute)
import RidesRequests.Model exposing (Collection, Msg(..))


new : Rides.Model.Model -> Collection -> Html Msg
new ride collection =
    case collection.new.response of
        Success _ ->
            styled div
                card
                []
                [ styled div cardTitle [] [ text "O pedido de carona foi enviado com sucesso!" ]
                , p [] [ text "Para combinar melhor a carona, use o contato abaixo:" ]
                , contactDetails ride.profile
                ]

        _ ->
            styled form
                card
                [ onSubmit (CreateRideRequest ride) ]
                (formFields ride collection)


contactDetails : Profile -> Html msg
contactDetails profile =
    contact []
        [ text <| profile.contact.kind ++ " "
        , a [ href <| contactDeepLink profile.contact, target "_blank" ] [ text profile.contact.value ]
        ]


formFields : Rides.Model.Model -> Collection -> List (Html Msg)
formFields ride collection =
    [ renderErrors collection.new.response
    , styled div cardTitle [] [ text "Confirme os detalhes da carona antes de confirmar" ]
    , br [] []
    , rideRoute ride
    , Rides.View.List.rideInfo ride
    , br [] []
    , loadingOrSubmitButton collection.new.response "submitRideRequest" [ text "Pedir carona" ]
    ]
