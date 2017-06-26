module Rides.View.RidesList exposing (ridesList)

import Common.CssHelpers exposing (materializeClass)
import Common.Icon exposing (icon)
import Rides.Model exposing (Model, Ride)
import Rides.Styles exposing (Classes(Card, CardTitle, OtherDetails, Path, PathIcon, PathIconDot), class)
import Testable.Html exposing (Html, a, div, hr, li, ol, p, span, strong, text)
import Testable.Html.Attributes exposing (href, id, rel, target)


ridesList : Model -> Html a
ridesList rides =
    div [ materializeClass "container" ] (List.map rideItem rides)


rideItem : Ride -> Html a
rideItem ride =
    a [ href ride.formUrl, target "_blank", class Card, materializeClass "card" ]
        [ div [ materializeClass "card-content" ]
            [ span [ class CardTitle ] [ text ride.destination ]
            , div [ class Path ]
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
            ]
        , div [ class OtherDetails, materializeClass "card-action" ]
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
        ]
