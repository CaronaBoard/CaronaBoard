module Rides.View.List exposing (list, rideInfo, rideRoute)

import Common.Icon exposing (icon)
import Common.IdentifiedList exposing (findById)
import Common.Link exposing (..)
import Groups.Model
import Groups.View.JoinRequests exposing (joinRequestList)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, id)
import Layout.Styles exposing (..)
import Model as Root exposing (Msg(..))
import RemoteData exposing (..)
import Rides.Model as Rides
import Rides.Styles exposing (..)
import UrlRouter.Routes exposing (Page(..))


list : String -> Root.Model -> Html Msg
list groupId { rides, groups } =
    case groups.list of
        NotAsked ->
            text ""

        Loading ->
            text "Carregando..."

        Success groups ->
            case findById groupId groups of
                Just group ->
                    ridesList group rides

                Nothing ->
                    h1 [] [ text "404 não encontrado" ]

        Failure err ->
            text err


ridesList : Groups.Model.Group -> Rides.Collection -> Html Msg
ridesList group rides =
    styled div
        container
        []
        [ pageTitle [] [ text group.name ]
        , joinRequestList group
        , case rides.list of
            NotAsked ->
                text ""

            Loading ->
                text "Carregando..."

            Success rides ->
                let
                    ridesForGroup =
                        List.filter (\ride -> ride.groupId == group.id) rides
                in
                if ridesForGroup == [] then
                    text "Esse grupo ainda não tem nenhuma oferta de carona. Tem um carro? Cadastre uma carona!"
                else
                    div []
                        [ div [] (List.map (rideItem group.id) ridesForGroup)
                        , p []
                            [ text "Tem um carro? Adicione sua carona "
                            , linkTo (RidesCreatePage group.id) [] [ text "aqui" ]
                            ]
                        ]

            Failure err ->
                text err
        ]


rideItem : String -> Rides.Model -> Html Msg
rideItem groupId ride =
    styled div
        card
        [ id "rideItem" ]
        [ styled span cardTitle [] [ text ride.destination ]
        , rideRoute ride
        , styled div
            otherDetails
            []
            [ rideInfo ride
            , linkTo (RideDetailsPage groupId ride.id) [ css actionButton ] [ text "Quero carona" ]
            ]
        ]


rideRoute : Rides.Model -> Html msg
rideRoute ride =
    styled div
        path
        []
        [ div []
            [ styled div pathIcon [] [ icon "more_vert" ]
            , styled span pathIconDot [] [ icon "radio_button_unchecked" ]
            , text <| "Origem: " ++ ride.origin
            ]
        , div []
            [ styled span pathIconDot [] [ icon "radio_button_unchecked" ]
            , text <| "Destino: " ++ ride.destination
            ]
        ]


rideInfo : Rides.Model -> Html msg
rideInfo ride =
    styled ul
        Rides.Styles.rideInfo
        []
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
