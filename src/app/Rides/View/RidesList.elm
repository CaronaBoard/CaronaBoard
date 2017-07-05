module Rides.View.RidesList exposing (rideInfo, rideRoute, ridesList)

import Common.CssHelpers exposing (materializeClass)
import Common.Icon exposing (icon)
import Common.IdentifiedList exposing (findById)
import Common.Link exposing (linkTo)
import Common.Response as Response exposing (Response(..))
import Html exposing (..)
import Layout.Styles exposing (Classes(..), layoutClass)
import Model as Root exposing (Msg(..))
import Rides.Ride.Model as Ride
import Rides.Styles exposing (Classes(..), className)
import UrlRouter.Routes exposing (Page(..))


ridesList : String -> Root.Model -> Html Msg
ridesList groupId { rides, groups } =
    let
        groupName =
            groups.groups
                |> Response.map (findById groupId >> Maybe.map .name >> Maybe.withDefault "")
                |> Response.withDefault ""
    in
    div [ layoutClass Container ]
        [ h1 [ layoutClass PageTitle ] [ text groupName ]
        , case rides.rides of
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
                    div [] (List.map (rideItem groupId) ridesForGroup)

            Error err ->
                text err
        ]


rideItem : String -> Ride.Model -> Html Msg
rideItem groupId ride =
    div [ className Card, materializeClass "card" ]
        [ div [ materializeClass "card-content" ]
            [ span [ className CardTitle ] [ text ride.destination ]
            , rideRoute ride
            ]
        , div [ className OtherDetails, materializeClass "card-action" ]
            [ rideInfo ride
            , linkTo (RidePage groupId ride.id) [ className ActionButton ] [ text "Quero carona" ]
            ]
        ]


rideRoute : Ride.Model -> Html msg
rideRoute ride =
    div [ className Path ]
        [ p []
            [ div [ className PathIcon ] [ icon "more_vert" ]
            , span [ className PathIconDot ] [ icon "radio_button_unchecked" ]
            , text <| "Origem: " ++ ride.origin
            ]
        , p []
            [ span [ className PathIconDot ] [ icon "radio_button_unchecked" ]
            , text <| "Destino: " ++ ride.destination
            ]
        ]


rideInfo : Ride.Model -> Html msg
rideInfo ride =
    div []
        [ p []
            [ icon "today"
            , text ride.days
            ]
        , p []
            [ icon "schedule"
            , text ride.hours
            ]
        , p []
            [ icon "directions_car"
            , text ride.profile.name
            ]
        ]
