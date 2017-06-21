module UrlRouter.Model exposing (..)

import Navigation exposing (Location)
import UrlRouter.Routes exposing (Page(..), pathParser)


type alias Model =
    { page : Page
    }


init : Location -> Model
init location =
    case pathParser location of
        Nothing ->
            { page = SplashScreenPage
            }

        Just page ->
            { page = page }
