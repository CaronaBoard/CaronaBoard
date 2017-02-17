module Router.Model exposing (..)

import Router.Routes exposing (Page(..), pathParser)
import Navigation exposing (Location)


type alias Model =
    { page : Page
    }


init : Location -> Model
init location =
    case pathParser location of
        Nothing ->
            { page = HomeRoute
            }

        Just page ->
            { page = page }
