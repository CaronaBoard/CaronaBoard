module Rides.View.GiveRide exposing (giveRide)

import Common.CssHelpers exposing (materializeClass)
import Testable.Html exposing (..)


giveRide : Html a
giveRide =
    div [ materializeClass "container" ]
        [ h1 [] [ text "Dar Carona" ]
        ]
