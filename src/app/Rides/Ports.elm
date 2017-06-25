port module Rides.Ports exposing (RawRide, decodeRide, subscriptions)

import Rides.Model exposing (Contact(..), Ride)
import Rides.Msg exposing (Msg(..))


subscriptions : Sub Msg
subscriptions =
    rides (decodeRides >> UpdateRides)


port rides : (List RawRide -> msg) -> Sub msg


type alias RawRide =
    { id : String
    , name : String
    , origin : String
    , destination : String
    , days : String
    , hours : String
    , formUrl : String
    , contactType : String
    , contactValue : String
    }


decodeRides : List RawRide -> List Ride
decodeRides =
    List.map decodeRide


decodeRide : RawRide -> Ride
decodeRide rawRide =
    { id = rawRide.id
    , name = rawRide.name
    , origin = rawRide.origin
    , destination = rawRide.destination
    , days = rawRide.days
    , hours = rawRide.hours
    , formUrl = rawRide.formUrl
    , contact = decodeContact rawRide.contactType rawRide.contactValue
    }


decodeContact : String -> String -> Maybe Contact
decodeContact type_ value =
    case type_ of
        "Whatsapp" ->
            Just <| Whatsapp value

        "Telegram" ->
            Just <| Telegram value

        _ ->
            Nothing
