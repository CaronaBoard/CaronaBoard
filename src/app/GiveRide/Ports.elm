port module GiveRide.Ports exposing (giveRide)

import GiveRide.Model exposing (NewRide)


port giveRide : NewRide -> Cmd msg
