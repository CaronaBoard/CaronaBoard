module Rides.View.RidesList exposing (rideInfo, rideRoute, ridesList)

import Common.CssHelpers exposing (materializeClass)
import Common.Icon exposing (icon)
import Common.Link exposing (linkTo)
import Model exposing (Msg(..))
import Rides.Model exposing (Model, Ride)
import Rides.Styles exposing (Classes(..), className)
import Testable.Html exposing (..)
import UrlRouter.Routes exposing (Page(..))


ridesList : Model -> Html Msg
ridesList rides =
    div [ materializeClass "container" ] (List.map rideItem rides)


rideItem : Ride -> Html Msg
rideItem ride =
    div [ className Card, materializeClass "card" ]
        [ div [ materializeClass "card-content" ]
            [ span [ className CardTitle ] [ text ride.destination ]
            , rideRoute ride
            ]
        , div [ className OtherDetails, materializeClass "card-action" ]
            [ rideInfo ride
            , linkTo (RideRequestPage ride.id) [ className ActionButton ] [ text "Quero carona" ]
            ]
        ]


rideRoute : Ride -> Html msg
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
            , text ride.profile.name
            ]
        ]
