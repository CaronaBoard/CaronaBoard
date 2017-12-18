module Common.Icon exposing (icon, iconLeft, iconRight)

import Css exposing (..)
import Html.Styled exposing (..)
import Layout.Styles exposing (..)


iconRight : String -> Html a
iconRight =
    icon_ materialIconRight


iconLeft : String -> Html a
iconLeft =
    icon_ materialIconLeft


icon : String -> Html a
icon =
    icon_ materialIcon


icon_ : List Style -> String -> Html msg
icon_ style name =
    styled i style [] [ text name ]
