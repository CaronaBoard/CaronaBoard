module UrlRouter.Msg exposing (Msg(..))

import Navigation exposing (Location)
import UrlRouter.Routes exposing (Page)


type Msg
    = Go Page
    | UrlChange Location
