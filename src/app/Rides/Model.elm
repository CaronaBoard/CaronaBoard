module Rides.Model exposing (Contact(..), Model, Ride, contactName, contactValue, init)


type alias Ride =
    { id : String
    , name : String
    , origin : String
    , destination : String
    , days : String
    , hours : String
    , contact : Maybe Contact
    }


type Contact
    = Whatsapp String
    | Telegram String


type alias Model =
    List Ride


init : Model
init =
    []


contactName : Contact -> String
contactName contact =
    case contact of
        Whatsapp value ->
            "Whatsapp"

        Telegram value ->
            "Telegram"


contactValue : Contact -> String
contactValue contact =
    case contact of
        Whatsapp value ->
            value

        Telegram value ->
            value
