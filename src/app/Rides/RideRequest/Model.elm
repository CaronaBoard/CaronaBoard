module Rides.RideRequest.Model exposing (Model, Msg(..), init)

import Common.Response exposing (FirebaseResponse, Response(..))


type alias Model =
    { response : Response Bool
    }


type Msg
    = Submit
    | RideRequestResponse (FirebaseResponse Bool)


init : Model
init =
    { response = Empty
    }
