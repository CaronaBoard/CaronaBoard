module UrlRouter.Msg exposing (Msg(..))

import UrlRouter.Routes exposing (Page)
import Navigation exposing (Location)


type Msg
    = Go Page
    | UrlChange Location
