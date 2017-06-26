module Rides.View.RidesList exposing (rideInfo, rideRoute, ridesList)

import Common.CssHelpers exposing (materializeClass)
import Common.Icon exposing (icon)
import Common.Link exposing (linkTo)
import Msg exposing (Msg(..))
import Rides.Model exposing (Model, Ride)
import Rides.Styles exposing (Classes(..), class)
import Testable.Html exposing (..)
import UrlRouter.Routes exposing (Page(..))


ridesList : Model -> Html Msg
ridesList rides =
    div [ materializeClass "container" ] (List.map rideItem rides)


rideItem : Ride -> Html Msg
rideItem ride =
    div [ class Card, materializeClass "card" ]
        [ div [ materializeClass "card-content" ]
            [ span [ class CardTitle ] [ text ride.destination ]
            , rideRoute ride
            ]
        , div [ class OtherDetails, materializeClass "card-action" ]
            [ rideInfo ride
            , linkTo (RideRequestPage ride.id) [ class ActionButton ] [ text "Quero carona" ]
            ]
        ]


rideRoute : Ride -> Html msg
rideRoute ride =
    div [ class Path ]
        [ p []
            [ div [ class PathIcon ] [ icon "more_vert" ]
            , span [ class PathIconDot ] [ icon "radio_button_unchecked" ]
            , text <| "Origem: " ++ ride.origin
            ]
        , p []
            [ span [ class PathIconDot ] [ icon "radio_button_unchecked" ]
            , text <| "Destino: " ++ ride.destination
            ]
        ]


rideInfo : Ride -> Html msg
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
            , text ride.name
            ]
        ]
