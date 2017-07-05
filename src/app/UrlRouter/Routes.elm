module UrlRouter.Routes exposing (Page(..), pathParser, redirectTo, toPath)

import Login.Model as Login exposing (isSignedIn)
import Navigation
import Profile.Model as Profile
import UrlParser exposing ((</>), Parser, map, oneOf, parseHash, string)


type Page
    = SplashScreenPage
    | LoginPage
    | RidesPage String
    | NotFoundPage
    | PasswordResetPage
    | GiveRidePage String
    | EnableNotificationsPage
    | RidePage String String
    | ProfilePage
    | GroupsPage


pageParser : Parser (Page -> a) a
pageParser =
    oneOf
        [ map SplashScreenPage (static "")
        , map LoginPage (static "login")
        , map PasswordResetPage (static "password-reset")
        , map ProfilePage (static "profile")
        , map EnableNotificationsPage (static "enable-notifications")
        , map GroupsPage (static "groups")
        , map RidesPage (static "groups" </> string </> static "rides")
        , map GiveRidePage (static "groups" </> string </> static "rides" </> static "give")
        , map RidePage (static "groups" </> string </> static "rides" </> string </> static "request")
        ]


toPath : Page -> String
toPath page =
    case page of
        SplashScreenPage ->
            "#/"

        LoginPage ->
            "#/login"

        RidesPage groupId ->
            "#/groups/" ++ groupId ++ "/rides"

        NotFoundPage ->
            "#/not-found"

        PasswordResetPage ->
            "#/password-reset"

        GiveRidePage groupId ->
            "#/groups/" ++ groupId ++ "/rides/give"

        EnableNotificationsPage ->
            "#/enable-notifications"

        RidePage groupId rideId ->
            "#/groups/" ++ groupId ++ "/rides/" ++ rideId ++ "/request"

        ProfilePage ->
            "#/profile"

        GroupsPage ->
            "#/groups"


redirectTo : Profile.Model -> Login.Model -> Page -> Page
redirectTo profile login page =
    if isSignedIn login then
        if profile.savedProfile == Nothing then
            ProfilePage
        else
            case page of
                SplashScreenPage ->
                    GroupsPage

                LoginPage ->
                    GroupsPage

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

        RidesPage _ ->
            True

        LoginPage ->
            False

        NotFoundPage ->
            False

        PasswordResetPage ->
            False

        GiveRidePage _ ->
            True

        EnableNotificationsPage ->
            True

        RidePage _ _ ->
            True

        ProfilePage ->
            True

        GroupsPage ->
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
