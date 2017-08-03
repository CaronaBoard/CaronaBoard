module Groups.View.JoinRequests exposing (joinRequestList)

import Groups.Model
import Groups.Styles exposing (Classes(..), className)
import Html exposing (..)
import Model as Root exposing (Msg(..))


joinRequestList : Groups.Model.Group -> Html Msg
joinRequestList group =
    div []
        (if List.length group.joinRequests > 0 then
            [ text "Pedidos de aprovação pendentes:"
            , ul [ className JoinRequests ] (List.map joinRequestItem group.joinRequests ++ List.map joinRequestItem group.joinRequests)
            ]
         else
            []
        )


joinRequestItem : Groups.Model.JoinRequest -> Html Msg
joinRequestItem joinRequest =
    li [ className JoinRequest ] [ text joinRequest.profile.name ]
