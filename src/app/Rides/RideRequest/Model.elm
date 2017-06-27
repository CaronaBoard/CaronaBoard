module Rides.RideRequest.Model exposing (Model, init)

import Common.Response exposing (Response(..))


type alias Model =
    { response : Response Bool
    }


init : Model
init =
    { response = Empty
    }
