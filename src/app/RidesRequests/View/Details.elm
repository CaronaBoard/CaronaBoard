module RidesRequests.View.Details exposing (details)

import Common.Response as Response exposing (Response(..))
import Html exposing (..)
import RidesRequests.Model exposing (Model, Msg(..))


details : Model -> Html msg
details model =
    case model of
        Success rideRequest ->
            text (rideRequest.profile.name ++ rideRequest.profile.contact.value)

        _ ->
            text ""
