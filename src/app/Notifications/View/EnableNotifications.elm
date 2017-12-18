module Notifications.View.EnableNotifications exposing (enableNotifications)

import Common.Form exposing (renderErrors, loadingOrSubmitButton)
import Common.Icon exposing (icon)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (disabled, id)
import Html.Styled.Events exposing (onSubmit)
import Layout.Styles exposing (Classes(..), styledLayoutClass)
import Notifications.Model exposing (Model, Msg(..))
import RemoteData exposing (..)


enableNotifications : Model -> Html Msg
enableNotifications model =
    div [ styledLayoutClass Container ]
        [ h1 [ styledLayoutClass PageTitle ] [ text "Ativar Notificações" ]
        , form [ styledLayoutClass Card, onSubmit EnableNotifications ]
            [ case model.response of
                Failure _ ->
                    renderErrors (Failure "As notificações não foram ativadas")

                _ ->
                    div [] []
            , p [] [ text "Precisamos que você ative as notificações pra ficar sabendo quando receber uma oferta ou pedido de carona e participação nos grupos" ]
            , br [] []
            , case model.response of
                Success _ ->
                    button [ disabled True, styledLayoutClass DisabledButton ]
                        [ div [ styledLayoutClass ButtonContainer ] [ fromUnstyled <| icon "done", text "Notificações ativadas" ] ]

                _ ->
                    loadingOrSubmitButton model.response "enableNotifications" [ text "Próximo", fromUnstyled <| icon "arrow_forward" ]
            ]
        ]
