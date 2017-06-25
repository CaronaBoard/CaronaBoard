module Notifications.Model exposing (Model, init, isEnabled)

import Common.Response exposing (Response(..))


type alias Model =
    { response : Response Bool
    }


init : Model
init =
    { response = Empty
    }


isEnabled : Model -> Bool
isEnabled model =
    case model.response of
        Success _ ->
            True

        _ ->
            False
