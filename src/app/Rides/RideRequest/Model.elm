module Rides.RideRequest.Model exposing (Model, Msg(..))

import Common.Response exposing (Response(..))


type alias Model =
    { response : Response Bool
    }


type Msg
    = Submit
    | RideRequestResponse (Response Bool)
