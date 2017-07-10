module Rides.View.List exposing (list, rideInfo, rideRoute)

import Common.Icon exposing (icon)
import Common.IdentifiedList exposing (findById)
import Common.Link exposing (linkTo)
import Common.Response as Response exposing (Response(..))
import Html exposing (..)
import Layout.Styles exposing (Classes(..), layoutClass)
import Model as Root exposing (Msg(..))
import Rides.Model as Ride
import Rides.Styles exposing (Classes(..), className)
import UrlRouter.Routes exposing (Page(..))


list : String -> Root.Model -> Html Msg
list groupId { rides, groups } =
    let
        groupName =
            groups.groups
                |> Response.map (findById groupId >> Maybe.map .name >> Maybe.withDefault "")
                |> Response.withDefault ""
    in
    div [ layoutClass Container ]
        [ h1 [ layoutClass PageTitle ] [ text groupName ]
        , case rides.list of
            Empty ->
                text ""

            Loading ->
                text "Carregando..."

            Success rides ->
                let
                    ridesForGroup =
                        List.filter (\ride -> ride.groupId == groupId) rides
                in
                if ridesForGroup == [] then
                    text "Esse grupo ainda não tem nenhuma oferta de carona. Tem um carro? Cadastre uma carona!"
                else
                    div []
                        [ div [] (List.map (rideItem groupId) ridesForGroup)
                        , p []
                            [ text "Tem um carro? Adicione sua carona "
                            , linkTo (RidesCreatePage groupId) [] [ text "aqui" ]
                            ]
                        ]

            Error err ->
                text err
        ]


rideItem : String -> Ride.Model -> Html Msg
rideItem groupId ride =
    div [ className Rides.Styles.Card ]
        [ span [ layoutClass CardTitle ] [ text ride.destination ]
        , rideRoute ride
        , div [ className OtherDetails ]
            [ rideInfo ride
            , linkTo (RideDetailsPage groupId ride.id) [ className ActionButton ] [ text "Quero carona" ]
            ]
        ]


rideRoute : Ride.Model -> Html msg
rideRoute ride =
    div [ className Path ]
        [ div []
            [ div [ className PathIcon ] [ icon "more_vert" ]
            , span [ className PathIconDot ] [ icon "radio_button_unchecked" ]
            , text <| "Origem: " ++ ride.origin
            ]
        , div []
            [ span [ className PathIconDot ] [ icon "radio_button_unchecked" ]
            , text <| "Destino: " ++ ride.destination
            ]
        ]


rideInfo : Ride.Model -> Html msg
rideInfo ride =
    ul [ className RideInfo ]
        [ li []
            [ icon "today"
            , text ride.days
            ]
        , li []
            [ icon "schedule"
            , text ride.hours
            ]
        , li []
            [ icon "directions_car"
            , text ride.profile.name
            ]
        ]
