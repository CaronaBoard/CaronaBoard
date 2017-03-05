module Common.Icon exposing (icon, iconLeft, iconRight)

import Testable.Html exposing (Html, i, text)
import Common.CssHelpers exposing (materializeClass)


iconRight : String -> Html a
iconRight =
    icon_ "right"


iconLeft : String -> Html a
iconLeft =
    icon_ "left"


icon : String -> Html a
icon =
    icon_ ""


icon_ : String -> String -> Html a
icon_ extraClasses name =
    i [ materializeClass <| "material-icons " ++ extraClasses ]
        [ text name ]
