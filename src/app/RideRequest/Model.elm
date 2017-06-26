module RideRequest.Model exposing (Model, RideRequest, init)

import Common.Response exposing (Response(..))


type alias Model =
    { fields : RideRequest
    , response : Response Bool
    }


type alias RideRequest =
    { name : String
    , contactType : String
    , contactValue : String
    }


init : Model
init =
    { fields =
        { name = ""
        , contactType = "Whatsapp"
        , contactValue = ""
        }
    , response = Empty
    }
