module UrlRouter.Routes exposing (Page(..), pathParser, redirectTo, toPath)

import Login.Model as Login exposing (isLoggedIn)
import Navigation
import UrlParser exposing ((</>), Parser, map, oneOf, parseHash, string)


type Page
    = SplashScreenPage
    | LoginPage
    | RidesPage
    | NotFoundPage
    | PasswordResetPage
    | GiveRidePage


pageParser : Parser (Page -> a) a
pageParser =
    oneOf
        [ map SplashScreenPage (static "")
        , map LoginPage (static "login")
        , map RidesPage (static "rides")
        , map PasswordResetPage (static "password-reset")
        , map GiveRidePage (static "give-ride")
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

        PasswordResetPage ->
            "#/password-reset"

        GiveRidePage ->
            "#/give-ride"


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

        PasswordResetPage ->
            PasswordResetPage

        GiveRidePage ->
            if isLoggedIn login then
                page
            else
                LoginPage


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
