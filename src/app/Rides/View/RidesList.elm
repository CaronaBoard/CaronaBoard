module Rides.View.RidesList exposing (rideInfo, rideRoute, ridesList)

import Common.CssHelpers exposing (materializeClass)
import Common.Icon exposing (icon)
import Common.Link exposing (linkTo)
import Model exposing (Msg(..))
import Rides.Model as Rides
import Rides.Ride.Model as Ride
import Rides.Styles exposing (Classes(..), className)
import Html exposing (..)
import UrlRouter.Routes exposing (Page(..))


ridesList : Rides.Model -> Html Msg
ridesList rides =
    div [ materializeClass "container" ] (List.map rideItem rides)


rideItem : Ride.Model -> Html Msg
rideItem ride =
    div [ className Card, materializeClass "card" ]
        [ div [ materializeClass "card-content" ]
            [ span [ className CardTitle ] [ text ride.destination ]
            , rideRoute ride
            ]
        , div [ className OtherDetails, materializeClass "card-action" ]
            [ rideInfo ride
            , linkTo (RidePage ride.id) [ className ActionButton ] [ text "Quero carona" ]
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
