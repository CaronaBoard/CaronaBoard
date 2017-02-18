module UrlRouter.Model exposing (..)

import UrlRouter.Routes exposing (Page(..), pathParser)
import Navigation exposing (Location)


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
