module RoutesBox.RoutesList exposing (routesList)

import Testable.Html exposing (Html, text, span, ol, li, a, div, strong, p, hr)
import Testable.Html.Attributes exposing (id, class, href, target, rel)
import Model exposing (Model, Rider)
import Common.Icon exposing (icon)


routesList : Model -> Html a
routesList model =
    div [ class "container" ] (List.map riderRoute model.riders)


riderRoute : Rider -> Html a
riderRoute rider =
    a [ href rider.formUrl, target "_blank", class "card rider-card" ]
        [ div [ class "card-content" ]
            ([ span [ class "card-title" ] [ text rider.area ]
             , div [ class "ride-path" ]
                [ p []
                    [ div [ class "icon-path" ] [ icon "more_vert" ]
                    , span [ class "icon-path-dot" ] [ icon "radio_button_unchecked" ]
                    , text <| "Origem: " ++ rider.origin
                    ]
                , p []
                    [ span [ class "icon-path-dot" ] [ icon "radio_button_unchecked" ]
                    , text <| "Destino: " ++ rider.destination
                    ]
                ]
             ]
                ++ (flexibleRoute rider)
            )
        , div [ class "card-action" ]
            [ p []
                [ icon "today"
                , text rider.days
                ]
            , p []
                [ icon "schedule"
                , text rider.hours
                ]
            , p []
                [ icon "directions_car"
                , text rider.name
                ]
            ]
        ]


flexibleRoute : Rider -> List (Html a)
flexibleRoute rider =
    if rider.flexible then
        [ p []
            [ icon "call_split"
            , text "Rota flexível"
            ]
        ]
    else
        []
