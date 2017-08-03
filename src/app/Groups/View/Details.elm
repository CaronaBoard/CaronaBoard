module Groups.View.Details exposing (details)

import Groups.Model exposing (Model)
import Html exposing (..)
import Model as Root exposing (Msg(..))


details : Model -> Html Root.Msg
details model =
    text "Você não faz parte desse grupo. [Participar do grupo]"
