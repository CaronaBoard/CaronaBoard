port module GiveRide.Ports exposing (encodeNewRide, giveRide, subscriptions)

import Common.Response exposing (FirebaseResponse, firebaseMap)
import GiveRide.Model exposing (NewRide)
import GiveRide.Msg exposing (Msg(..))
import Login.Model exposing (User)
import Rides.Model exposing (Contact)
import Rides.Ports exposing (RawRide, decodeRide)


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ giveRideResponse (firebaseMap decodeRide >> GiveRideResponse)
        ]


port giveRide : RawNewRide -> Cmd msg


port giveRideResponse : (FirebaseResponse RawRide -> msg) -> Sub msg


type alias RawNewRide =
    { userId : String
    , name : String
    , origin : String
    , destination : String
    , days : String
    , hours : String
    , contact : Contact
    }


encodeNewRide : User -> NewRide -> RawNewRide
encodeNewRide user newRide =
    { userId = user.id
    , name = newRide.name
    , origin = newRide.origin
    , destination = newRide.destination
    , days = newRide.days
    , hours = newRide.hours
    , contact = newRide.contact
    }
