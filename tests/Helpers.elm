module Helpers exposing (toLocation)

import Navigation exposing (Location)
import UrlRouter.Routes exposing (Page(..), toPath)


toLocation : Page -> Location
toLocation page =
    { href = "", host = "", hostname = "", protocol = "", origin = "", port_ = "", pathname = "", search = "", hash = toPath page, username = "", password = "" }
