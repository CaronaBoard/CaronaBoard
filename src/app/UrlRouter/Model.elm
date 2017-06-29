module UrlRouter.Model exposing (Model, Msg(..), init)

import Navigation exposing (Location)
import UrlRouter.Routes exposing (Page(..), pathParser)


type alias Model =
    { page : Page
    }


type Msg
    = Go Page
    | UrlChange Location


init : Location -> Model
init location =
    case pathParser location of
        Nothing ->
            { page = SplashScreenPage
            }

        Just page ->
            { page = page }
