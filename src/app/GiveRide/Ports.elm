port module GiveRide.Ports exposing (giveRide)


port giveRide :
    { name : String
    , origin : String
    , destination : String
    , days : String
    , hours : String
    }
    -> Cmd msg
