module Router.Routes exposing (..)

import UrlParser exposing (Parser, (</>), map, oneOf, string, parseHash)
import Navigation


type Page
    = HomeRoute
    | LoginRoute
    | RidesRoute


pageParser : Parser (Page -> a) a
pageParser =
    oneOf
        [ map HomeRoute (static "")
        , map LoginRoute (static "login")
        , map RidesRoute (static "rides")
        ]


toPath : Page -> String
toPath page =
    case page of
        HomeRoute ->
            "#"

        LoginRoute ->
            "#login"

        RidesRoute ->
            "#rides"


pathParser : Navigation.Location -> Maybe Page
pathParser location =
    if location.hash == "" then
        Just HomeRoute
    else
        parseHash pageParser location


static : String -> Parser a a
static =
    UrlParser.s
