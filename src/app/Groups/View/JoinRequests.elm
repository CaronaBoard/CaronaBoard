module Groups.View.JoinRequests exposing (joinRequestList)

import Common.Icon exposing (icon)
import Common.Response exposing (Response(..))
import Groups.Model exposing (Msg(..), pendingJoinRequests)
import Groups.Styles exposing (Classes(..), className)
import Html exposing (..)
import Html.Attributes exposing (id)
import Html.Events exposing (onClick)
import Model as Root exposing (Msg(..))


joinRequestList : Groups.Model.Group -> Html Root.Msg
joinRequestList group =
    div []
        (if List.length (pendingJoinRequests group) > 0 then
            [ text "Pedidos de aprovação pendentes:"
            , ul [ className JoinRequests ]
                (List.map (joinRequestItem group) (pendingJoinRequests group))
            ]
         else
            []
        )


joinRequestItem : Groups.Model.Group -> Groups.Model.JoinRequest -> Html Root.Msg
joinRequestItem group joinRequest =
    li [ className JoinRequest ]
        [ text joinRequest.profile.name
        , div []
            [ button
                [ id "acceptJoinRequest"
                , className RespondButton
                , onClick (MsgForGroups <| RespondJoinRequest group.id joinRequest.userId True)
                ]
                [ icon "check" ]
            , button
                [ id "rejectJoinRequest"
                , className RespondButton
                , onClick (MsgForGroups <| RespondJoinRequest group.id joinRequest.userId False)
                ]
                [ icon "close" ]
            ]
        ]
