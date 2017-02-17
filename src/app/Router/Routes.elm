module Router.Routes exposing (toPath, redirectTo, pathParser, Page(..))

import UrlParser exposing (Parser, (</>), map, oneOf, string, parseHash)
import Navigation
import Login.Model as Login exposing (isLoggedIn)


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


redirectTo : Login.Model -> Page -> Page
redirectTo login page =
    case page of
        HomeRoute ->
            if isLoggedIn login then
                RidesRoute
            else
                LoginRoute

        RidesRoute ->
            if isLoggedIn login then
                page
            else
                LoginRoute

        LoginRoute ->
            if isLoggedIn login then
                RidesRoute
            else
                page


pathParser : Navigation.Location -> Maybe Page
pathParser location =
    if location.hash == "" then
        Just HomeRoute
    else
        parseHash pageParser location


static : String -> Parser a a
static =
    UrlParser.s
