module UrlRouter.Routes exposing (Page(..), pathParser, redirectTo, toPath)

import Login.Model as Login exposing (isLoggedIn)
import Navigation
import Profile.Model as Profile
import UrlParser exposing ((</>), Parser, map, oneOf, parseHash, string)


type Page
    = SplashScreenPage
    | LoginPage
    | RidesPage
    | NotFoundPage
    | PasswordResetPage
    | GiveRidePage
    | EnableNotificationsPage
    | RideRequestPage String
    | ProfilePage


pageParser : Parser (Page -> a) a
pageParser =
    oneOf
        [ map SplashScreenPage (static "")
        , map LoginPage (static "login")
        , map RidesPage (static "rides")
        , map PasswordResetPage (static "password-reset")
        , map GiveRidePage (static "give-ride")
        , map EnableNotificationsPage (static "enable-notifications")
        , map RideRequestPage (static "request-ride" </> string)
        , map ProfilePage (static "profile")
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

        EnableNotificationsPage ->
            "#/enable-notifications"

        RideRequestPage rideId ->
            "#/request-ride/" ++ rideId

        ProfilePage ->
            "#/profile"


redirectTo : Profile.Model -> Login.Model -> Page -> Page
redirectTo profile login page =
    if isLoggedIn login then
        if profile.savedProfile == Nothing then
            ProfilePage
        else
            case page of
                SplashScreenPage ->
                    RidesPage

                LoginPage ->
                    RidesPage

                _ ->
                    page
    else if requiresAuthentication page then
        LoginPage
    else
        page


requiresAuthentication : Page -> Bool
requiresAuthentication page =
    case page of
        SplashScreenPage ->
            True

        RidesPage ->
            True

        LoginPage ->
            False

        NotFoundPage ->
            False

        PasswordResetPage ->
            False

        GiveRidePage ->
            True

        EnableNotificationsPage ->
            True

        RideRequestPage _ ->
            True

        ProfilePage ->
            True


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
