module Profile.Model exposing (Contact, Model, Msg(..), Profile, contactDeepLink, contactIdentifier, validation)

import Common.Response exposing (..)
import Form exposing (Form)
import Form.Validate as Validate exposing (..)


type alias Model =
    { fields : Form () Profile
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
    = FormMsg Form.Msg
    | ProfileResponse (Response Profile)


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


validation : Validation () Profile
validation =
    Validate.succeed Profile
        |> Validate.andMap (field "name" string)
        |> Validate.andMap
            (Validate.succeed Contact
                |> Validate.andMap (field "contactKind" string)
                |> Validate.andMap (field "contactValue" string)
            )
