module Common.Icon exposing (icon, iconLeft, iconRight)

import Html.Styled exposing (Html, i, text)
import Layout.Styles exposing (Classes(..), layoutClass)


iconRight : String -> Html a
iconRight =
    icon_ MaterialIconRight


iconLeft : String -> Html a
iconLeft =
    icon_ MaterialIconLeft


icon : String -> Html a
icon =
    icon_ MaterialIcon


icon_ : Layout.Styles.Classes -> String -> Html a
icon_ class_ name =
    i [ layoutClass class_ ]
        [ text name ]
