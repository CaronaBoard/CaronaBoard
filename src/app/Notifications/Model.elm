module Notifications.Model exposing (Model, init)

import Common.Response exposing (Response(..))


type alias Model =
    { response : Response ()
    }


init : Model
init =
    { response = Empty
    }
