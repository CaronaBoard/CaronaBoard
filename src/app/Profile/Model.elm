module Profile.Model exposing (Model, Profile, init, savedProfile)

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


init : Maybe Profile -> Model
init profile =
    { fields =
        { name = ""
        , contact = { kind = "Whatsapp", value = "" }
        }
    , response =
        profile
            |> Maybe.map Success
            |> Maybe.withDefault Empty
    }


savedProfile : Model -> Maybe Profile
savedProfile model =
    case model.response of
        Success profile ->
            Just profile

        _ ->
            Nothing
