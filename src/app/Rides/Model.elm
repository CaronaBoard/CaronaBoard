module Rides.Model exposing (Contact, Model, Ride, contactDeepLink, contactIdentifier, init)


type alias Ride =
    { id : String
    , name : String
    , origin : String
    , destination : String
    , days : String
    , hours : String
    , contact : Contact
    }


type alias Contact =
    { kind : String
    , value : String
    }


type alias Model =
    List Ride


init : Model
init =
    []


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
contactIdentifier contactType =
    if contactType == "Telegram" then
        "Nick"
    else
        "Número"
