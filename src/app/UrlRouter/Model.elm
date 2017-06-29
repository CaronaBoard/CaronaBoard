module UrlRouter.Model exposing (Model, Msg(..))

import Navigation exposing (Location)
import UrlRouter.Routes exposing (Page(..), pathParser)


type alias Model =
    { page : Page
    }


type Msg
    = Go Page
    | UrlChange Location
