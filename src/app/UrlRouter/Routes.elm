module UrlRouter.Routes exposing (Page(..), pathParser, redirectTo, requiresAuthentication, toPath)

import Login.Model as Login exposing (isSignedIn)
import Navigation
import Profile.Model as Profile
import UrlParser exposing ((</>), Parser, map, oneOf, parseHash, string)


type Page
    = SplashScreenPage
    | LoginPage
    | PasswordStepPage
    | RegistrationPage
    | PasswordResetPage
    | NotFoundPage
    | ProfilePage
    | EnableNotificationsPage
    | GroupsPage
    | RidesPage String
    | GiveRidePage String
    | RidePage String String
    | RideRequestPage String String String String


pageParser : Parser (Page -> a) a
pageParser =
    oneOf
        [ map SplashScreenPage (static "")
        , map LoginPage (static "login")
        , map PasswordStepPage (static "login" </> static "password")
        , map RegistrationPage (static "login" </> static "registration")
        , map PasswordResetPage (static "password-reset")
        , map ProfilePage (static "profile")
        , map EnableNotificationsPage (static "enable-notifications")
        , map GroupsPage (static "groups")
        , map RidesPage (static "groups" </> string </> static "rides")
        , map GiveRidePage (static "groups" </> string </> static "rides" </> static "give")
        , map RidePage (static "groups" </> string </> static "rides" </> string </> static "request")
        , map RideRequestPage (static "groups" </> string </> static "rides" </> string </> static "requests" </> string </> string)
        ]


toPath : Page -> String
toPath page =
    case page of
        SplashScreenPage ->
            "#/"

        LoginPage ->
            "#/login"

        PasswordStepPage ->
            "#/login/password"

        RegistrationPage ->
            "#/login/registration"

        PasswordResetPage ->
            "#/password-reset"

        NotFoundPage ->
            "#/not-found"

        ProfilePage ->
            "#/profile"

        EnableNotificationsPage ->
            "#/enable-notifications"

        GroupsPage ->
            "#/groups"

        RidesPage groupId ->
            "#/groups/" ++ groupId ++ "/rides"

        GiveRidePage groupId ->
            "#/groups/" ++ groupId ++ "/rides/give"

        RidePage groupId rideId ->
            "#/groups/" ++ groupId ++ "/rides/" ++ rideId ++ "/request"

        RideRequestPage groupId rideId fromUserId requestId ->
            "#/groups/" ++ groupId ++ "/rides/" ++ rideId ++ "/requests/" ++ fromUserId ++ "/" ++ requestId


redirectTo : Maybe Page -> Profile.Model -> Login.Model -> Page -> Page
redirectTo returnTo profile login page =
    if isSignedIn login then
        if profile.savedProfile == Nothing then
            ProfilePage
        else
            case page of
                SplashScreenPage ->
                    GroupsPage

                LoginPage ->
                    Maybe.withDefault GroupsPage returnTo

                PasswordStepPage ->
                    Maybe.withDefault GroupsPage returnTo

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

        LoginPage ->
            False

        PasswordStepPage ->
            False

        RegistrationPage ->
            False

        PasswordResetPage ->
            False

        NotFoundPage ->
            False

        ProfilePage ->
            True

        EnableNotificationsPage ->
            True

        GroupsPage ->
            True

        RidesPage _ ->
            True

        GiveRidePage _ ->
            True

        RidePage _ _ ->
            True

        RideRequestPage _ _ _ _ ->
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
