module Profile.Model exposing (Model, Profile, init)

import Common.Response exposing (Response(..))
import Rides.Model exposing (Contact)


type alias Model =
    { fields : Profile
    , response : Response Profile
    }


type alias Profile =
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
