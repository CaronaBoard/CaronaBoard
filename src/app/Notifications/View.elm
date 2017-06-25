module Notifications.View exposing (enableNotifications)

import Common.CssHelpers exposing (materializeClass)
import Common.Form exposing (loadingOrSubmitButton, renderErrors)
import Layout.Styles exposing (Classes(..), class)
import Notifications.Model exposing (Model)
import Notifications.Msg exposing (Msg(..))
import Testable.Html exposing (..)
import Testable.Html.Attributes exposing (id)
import Testable.Html.Events exposing (onSubmit)


enableNotifications : Model -> Html Msg
enableNotifications model =
    div [ materializeClass "container" ]
        [ h1 [ class PageTitle ] [ text "Ativar Notificações" ]
        , form [ materializeClass "card", onSubmit EnableNotifications ]
            [ div [ materializeClass "card-content" ]
                [ renderErrors model.response
                , p [] [ text "Sua oferta de carona foi cadastrada!" ]
                , br [] []
                , p [] [ text "Agora você precisa ativar as notificações para ficar sabendo quando alguém te pedir uma carona" ]
                , br [] []
                , loadingOrSubmitButton model.response [ id "enableNotifications", class SubmitButton ] [ text "Ativar Notificações" ]
                ]
            ]
        ]
