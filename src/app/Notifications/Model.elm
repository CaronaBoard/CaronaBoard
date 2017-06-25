module Notifications.Model exposing (Model, init, isEnabled)

import Common.Response exposing (Response(..))


type alias Model =
    { response : Response Bool
    , notice : Maybe String
    }


init : Model
init =
    { response = Empty
    , notice = Nothing
    }


isEnabled : Model -> Bool
isEnabled model =
    case model.response of
        Success _ ->
            True

        _ ->
            False
