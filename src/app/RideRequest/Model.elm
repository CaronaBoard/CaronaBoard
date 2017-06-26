module RideRequest.Model exposing (Model, RideRequest, init)

import Common.Response exposing (Response(..))
import Rides.Model exposing (Contact)


type alias Model =
    { fields : RideRequest
    , response : Response Bool
    }


type alias RideRequest =
    { name : String
    , contact : Contact
    }


init : Model
init =
    { fields =
        { name = ""
        , contact = { kind = "Whatsapp", value = "" }
        }
    , response = Empty
    }
