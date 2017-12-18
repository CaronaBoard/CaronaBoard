module Notifications.View.EnableNotifications exposing (enableNotifications)

import Common.Form exposing (renderErrors, loadingOrSubmitButton)
import Common.Icon exposing (icon)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (disabled, id)
import Html.Styled.Events exposing (onSubmit)
import Layout.Styles exposing (Classes(..), layoutClass)
import Notifications.Model exposing (Model, Msg(..))
import RemoteData exposing (..)


enableNotifications : Model -> Html Msg
enableNotifications model =
    div [ layoutClass Container ]
        [ h1 [ layoutClass PageTitle ] [ text "Ativar Notificações" ]
        , form [ layoutClass Card, onSubmit EnableNotifications ]
            [ case model.response of
                Failure _ ->
                    renderErrors (Failure "As notificações não foram ativadas")

                _ ->
                    div [] []
            , p [] [ text "Precisamos que você ative as notificações pra ficar sabendo quando receber uma oferta ou pedido de carona e participação nos grupos" ]
            , br [] []
            , case model.response of
                Success _ ->
                    button [ disabled True, layoutClass DisabledButton ]
                        [ div [ layoutClass ButtonContainer ] [ icon "done", text "Notificações ativadas" ] ]

                _ ->
                    loadingOrSubmitButton model.response "enableNotifications" [ text "Próximo", icon "arrow_forward" ]
            ]
        ]
