module UrlRouter.Model exposing (Model, Msg(..))

import Navigation exposing (Location)
import UrlRouter.Routes exposing (Page(..), pathParser)


type alias Model =
    { page : Page
    , returnTo : Maybe Page
    }


type Msg
    = Go Page
    | UrlChange Location
    | Back
