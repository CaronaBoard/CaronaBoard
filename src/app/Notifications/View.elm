module Notifications.View exposing (enableNotifications)

import Common.CssHelpers exposing (materializeClass)
import Common.Form exposing (loadingOrSubmitButton)
import Common.Response exposing (Response(..))
import Layout.Styles exposing (Classes(..), class)
import Testable.Html exposing (..)


enableNotifications : Html a
enableNotifications =
    div [ materializeClass "container" ]
        [ h1 [ class PageTitle ] [ text "Ativar Notificações" ]
        , div [ materializeClass "card" ]
            [ div [ materializeClass "card-content" ]
                [ p [] [ text "Sua oferta de carona foi cadastrada!" ]
                , br [] []
                , p [] [ text "Agora você precisa ativar as notificações para ficar sabendo quando alguém te pedir uma carona" ]
                , br [] []
                , loadingOrSubmitButton Empty [ class SubmitButton ] [ text "Ativar Notificações" ]
                ]
            ]
        ]
