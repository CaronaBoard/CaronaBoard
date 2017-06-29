module Notifications.Model exposing (Model, Msg(..), isEnabled)

import Common.Response exposing (FirebaseResponse, Response(..))


type alias Model =
    { response : Response Bool
    , notice : Maybe String
    }


type Msg
    = EnableNotifications
    | NotificationsResponse (FirebaseResponse Bool)
    | ShowNotice String
    | HideNotice


isEnabled : Model -> Bool
isEnabled model =
    case model.response of
        Success _ ->
            True

        _ ->
            False
