module Groups.View.JoinRequests exposing (joinRequestList)

import Common.Icon exposing (icon)
import Groups.Model exposing (Msg(..), pendingJoinRequests)
import Groups.Styles exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (id)
import Html.Styled.Events exposing (onClick)
import Model as Root exposing (Msg(..))


joinRequestList : Groups.Model.Group -> Html Root.Msg
joinRequestList group =
    div []
        (if List.length (pendingJoinRequests group) > 0 then
            [ text "Pedidos de aprovação pendentes:"
            , styled ul
                joinRequests
                []
                (List.map (joinRequestItem group) (pendingJoinRequests group))
            ]
         else
            []
        )


joinRequestItem : Groups.Model.Group -> Groups.Model.JoinRequest -> Html Root.Msg
joinRequestItem group request =
    styled li
        joinRequest
        []
        [ text request.profile.name
        , div []
            [ styled button
                respondButton
                [ id "acceptJoinRequest"
                , onClick (MsgForGroups <| RespondJoinRequest group.id request.userId True)
                ]
                [ fromUnstyled <| icon "check" ]
            , styled button
                respondButton
                [ id "rejectJoinRequest"
                , onClick (MsgForGroups <| RespondJoinRequest group.id request.userId False)
                ]
                [ fromUnstyled <| icon "close" ]
            ]
        ]
