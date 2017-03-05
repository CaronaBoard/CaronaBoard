module Rides.View.RoutesList exposing (routesList)

import Testable.Html exposing (Html, text, span, ol, li, a, div, strong, p, hr)
import Testable.Html.Attributes exposing (id, class, href, target, rel)
import Rides.Model exposing (Model, Ride)
import Common.Icon exposing (icon)
import Rides.Styles exposing (scopedClass, Classes(Card, CardTitle, OtherDetails, Path, PathIcon, PathIconDot))


routesList : Model -> Html a
routesList rides =
    div [ class "container" ] (List.map rideRoute rides)


rideRoute : Ride -> Html a
rideRoute ride =
    a [ href ride.formUrl, target "_blank", class "card", scopedClass [ Card ] ]
        [ div [ class "card-content" ]
            ([ span [ scopedClass [ CardTitle ] ] [ text ride.area ]
             , div [ scopedClass [ Path ] ]
                [ p []
                    [ div [ scopedClass [ PathIcon ] ] [ icon "more_vert" ]
                    , span [ scopedClass [ PathIconDot ] ] [ icon "radio_button_unchecked" ]
                    , text <| "Origem: " ++ ride.origin
                    ]
                , p []
                    [ span [ scopedClass [ PathIconDot ] ] [ icon "radio_button_unchecked" ]
                    , text <| "Destino: " ++ ride.destination
                    ]
                ]
             ]
                ++ (flexibleRoute ride)
            )
        , div [ class "card-action", scopedClass [ OtherDetails ] ]
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
