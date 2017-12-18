module Notifications.View.EnableNotifications exposing (enableNotifications)

import Common.Form exposing (loadingOrSubmitButton, renderErrors)
import Common.Icon exposing (icon)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (disabled, id)
import Html.Styled.Events exposing (onSubmit)
import Layout.Styles exposing (..)
import Notifications.Model exposing (Model, Msg(..))
import RemoteData exposing (..)


enableNotifications : Model -> Html Msg
enableNotifications model =
    styled div
        container
        []
        [ pageTitle [] [ text "Ativar Notificações" ]
        , styled form
            card
            [ onSubmit EnableNotifications ]
            [ case model.response of
                Failure _ ->
                    renderErrors (Failure "As notificações não foram ativadas")

                _ ->
                    div [] []
            , p [] [ text "Precisamos que você ative as notificações pra ficar sabendo quando receber uma oferta ou pedido de carona e participação nos grupos" ]
            , br [] []
            , case model.response of
                Success _ ->
                    styled Html.Styled.button
                        disabledButton
                        [ disabled True ]
                        [ styled div buttonContainer [] [ icon "done", text "Notificações ativadas" ] ]

                _ ->
                    loadingOrSubmitButton model.response "enableNotifications" [ text "Próximo", icon "arrow_forward" ]
            ]
        ]
