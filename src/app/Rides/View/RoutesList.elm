module Rides.View.RoutesList exposing (routesList)

import Testable.Html exposing (Html, text, span, ol, li, a, div, strong, p, hr)
import Testable.Html.Attributes exposing (id, href, target, rel)
import Rides.Model exposing (Model, Ride)
import Common.Icon exposing (icon)
import Rides.Styles exposing (class, Classes(Card, CardTitle, OtherDetails, Path, PathIcon, PathIconDot))
import Common.CssHelpers exposing (materializeClass)


routesList : Model -> Html a
routesList rides =
    div [ materializeClass "container" ] (List.map rideRoute rides)


rideRoute : Ride -> Html a
rideRoute ride =
    a [ href ride.formUrl, target "_blank", class Card, materializeClass "card" ]
        [ div [ materializeClass "card-content" ]
            ([ span [ class CardTitle ] [ text ride.area ]
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
                ++ (flexibleRoute ride)
            )
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


flexibleRoute : Ride -> List (Html a)
flexibleRoute ride =
    if ride.flexible then
        [ p []
            [ icon "call_split"
            , text "Rota flexível"
            ]
        ]
    else
        []
