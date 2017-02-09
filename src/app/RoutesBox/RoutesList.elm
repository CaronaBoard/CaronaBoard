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
    a [ href "http://goo.gl/forms/R5f1MI6WV2", target "_blank", class "card rider-card" ]
        [ div [ class "card-content" ]
            [ span [ class "card-title" ] [ text "Aeroporto" ]
            , div [ class "ride-path" ]
                [ p []
                    [ div [ class "icon-path" ] [ icon "more_vert" ]
                    , span [ class "icon-path-dot" ] [ icon "radio_button_unchecked" ]
                    , text "Origem: Tecnopuc"
                    ]
                , p []
                    [ span [ class "icon-path-dot" ] [ icon "radio_button_unchecked" ]
                    , text "Destino: Estação Trensurb Bairro Anchieta"
                    ]
                ]
            , p []
                [ icon "call_split"
                , text "Rota flexível"
                ]
            ]
        , div [ class "card-action" ]
            [ p []
                [ icon "today"
                , text "Seg, Sex e Qua"
                ]
            , p []
                [ icon "schedule"
                , text "Ida 19h / volta 20:00"
                ]
            , p []
                [ icon "directions_car"
                , text rider.name
                ]
            ]
        ]
