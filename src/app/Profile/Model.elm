module Profile.Model exposing (Contact, Model, Profile, contactDeepLink, contactIdentifier, init)

import Common.Response exposing (Response(..))


type alias Model =
    { fields : Profile
    , savedProfile : Maybe Profile
    , response : Response Profile
    }


type alias Profile =
    { name : String
    , contact : Contact
    }


type alias Contact =
    { kind : String
    , value : String
    }


init : Maybe Profile -> Model
init profile =
    { fields =
        { name = ""
        , contact = { kind = "Whatsapp", value = "" }
        }
    , savedProfile = profile
    , response = Empty
    }


contactDeepLink : Contact -> String
contactDeepLink contact =
    case contact.kind of
        "Whatsapp" ->
            "whatsapp://send?phone=" ++ contact.value

        "Telegram" ->
            "tg://resolve?domain=" ++ contact.value

        _ ->
            contact.value


contactIdentifier : String -> String
contactIdentifier contactKind =
    if contactKind == "Telegram" then
        "Nick"
    else
        "Número"
