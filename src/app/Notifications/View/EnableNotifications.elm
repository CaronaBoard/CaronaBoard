module Notifications.View.EnableNotifications exposing (enableNotifications)

import Common.CssHelpers exposing (materializeClass)
import Common.Form exposing (loadingOrSubmitButton, renderErrors)
import Common.Icon exposing (icon)
import Common.Response exposing (Response(..))
import Html exposing (..)
import Html.Attributes exposing (disabled, id)
import Html.Events exposing (onSubmit)
import Layout.Styles exposing (Classes(..), layoutClass)
import Notifications.Model exposing (Model, Msg(..))


enableNotifications : Model -> Html Msg
enableNotifications model =
    div [ layoutClass Container ]
        [ h1 [ layoutClass PageTitle ] [ text "Ativar Notificações" ]
        , form [ layoutClass Card, onSubmit EnableNotifications ]
            [ case model.response of
                Error _ ->
                    renderErrors (Error "As notificações não foram ativadas")

                _ ->
                    div [] []
            , div [ layoutClass CardTitle ] [ text "Sua oferta de carona foi cadastrada!" ]
            , p [] [ text "Agora você precisa ativar as notificações para ficar sabendo quando alguém te pedir uma carona" ]
            , br [] []
            , case model.response of
                Success _ ->
                    button [ disabled True, layoutClass SubmitButton, materializeClass "waves-effect waves-light btn-large" ]
                        [ div [ layoutClass ButtonContainer ] [ icon "done", text "Notificações ativadas" ] ]

                _ ->
                    loadingOrSubmitButton model.response [ id "enableNotifications", layoutClass SubmitButton ] [ text "Ativar Notificações" ]
            ]
        ]
