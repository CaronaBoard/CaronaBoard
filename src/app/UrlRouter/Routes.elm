module UrlRouter.Routes exposing (toPath, redirectTo, pathParser, Page(..))

import UrlParser exposing (Parser, (</>), map, oneOf, string, parseHash)
import Navigation
import Login.Model as Login exposing (isLoggedIn)


type Page
    = SplashScreenPage
    | LoginPage
    | RidesPage
    | NotFoundPage


pageParser : Parser (Page -> a) a
pageParser =
    oneOf
        [ map SplashScreenPage (static "")
        , map LoginPage (static "login")
        , map RidesPage (static "rides")
        ]


toPath : Page -> String
toPath page =
    case page of
        SplashScreenPage ->
            "#/"

        LoginPage ->
            "#/login"

        RidesPage ->
            "#/rides"

        NotFoundPage ->
            "#/not-found"


redirectTo : Login.Model -> Page -> Page
redirectTo login page =
    case page of
        SplashScreenPage ->
            if isLoggedIn login then
                RidesPage
            else
                LoginPage

        RidesPage ->
            if isLoggedIn login then
                page
            else
                LoginPage

        LoginPage ->
            if isLoggedIn login then
                RidesPage
            else
                page

        NotFoundPage ->
            NotFoundPage


pathParser : Navigation.Location -> Maybe Page
pathParser location =
    -- This if is here due to this issue https://github.com/evancz/url-parser/issues/21
    if location.hash == "" then
        Just SplashScreenPage
    else
        parseHash pageParser location


static : String -> Parser a a
static =
    UrlParser.s
