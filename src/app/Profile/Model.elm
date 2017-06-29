module Profile.Model exposing (Contact, Model, Msg(..), Profile, contactDeepLink, contactIdentifier, init)

import Common.Response exposing (FirebaseResponse, Response(..))


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


type Msg
    = UpdateName String
    | UpdateContactKind String
    | UpdateContactValue String
    | Submit
    | ProfileResponse (FirebaseResponse Profile)


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
