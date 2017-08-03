module UrlRouter.Routes exposing (Page(..), pathParser, redirectTo, requiresAuthentication, toPath)

import Login.Model as Login exposing (isSignedIn)
import Navigation
import Profile.Model as Profile
import UrlParser exposing ((</>), Parser, map, oneOf, parseHash, string, top)


type Page
    = SplashScreenPage
    | LoginPage
    | PasswordStepPage
    | RegistrationPage
    | PasswordResetPage
    | NotFoundPage
    | ProfilePage
    | EnableNotificationsPage
    | GroupsListPage
    | GroupDetailsPage String
    | RidesListPage String
    | RidesCreatePage String
    | RideDetailsPage String String
    | RideRequestDetailsPage String String String String


pageParser : Parser (Page -> a) a
pageParser =
    oneOf
        [ map SplashScreenPage top
        , map LoginPage (static "login")
        , map PasswordStepPage (static "login" </> static "password")
        , map RegistrationPage (static "login" </> static "registration")
        , map PasswordResetPage (static "password-reset")
        , map ProfilePage (static "profile")
        , map EnableNotificationsPage (static "enable-notifications")
        , map GroupsListPage (static "groups")
        , map GroupDetailsPage (static "groups" </> string)
        , map RidesListPage (static "groups" </> string </> static "rides")
        , map RidesCreatePage (static "groups" </> string </> static "rides" </> static "give")
        , map RideDetailsPage (static "groups" </> string </> static "rides" </> string </> static "request")
        , map RideRequestDetailsPage (static "groups" </> string </> static "rides" </> string </> static "requests" </> string </> string)
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

        GroupsListPage ->
            "#/groups"

        GroupDetailsPage groupId ->
            "#/groups/" ++ groupId

        RidesListPage groupId ->
            "#/groups/" ++ groupId ++ "/rides"

        RidesCreatePage groupId ->
            "#/groups/" ++ groupId ++ "/rides/give"

        RideDetailsPage groupId rideId ->
            "#/groups/" ++ groupId ++ "/rides/" ++ rideId ++ "/request"

        RideRequestDetailsPage groupId rideId fromUserId requestId ->
            "#/groups/" ++ groupId ++ "/rides/" ++ rideId ++ "/requests/" ++ fromUserId ++ "/" ++ requestId


redirectTo : Maybe Page -> Profile.Model -> Login.Model -> Page -> Page
redirectTo returnTo profile login page =
    if isSignedIn login then
        if profile.savedProfile == Nothing then
            ProfilePage
        else
            case page of
                SplashScreenPage ->
                    GroupsListPage

                LoginPage ->
                    Maybe.withDefault GroupsListPage returnTo

                PasswordStepPage ->
                    Maybe.withDefault GroupsListPage returnTo

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

        GroupsListPage ->
            True

        GroupDetailsPage _ ->
            True

        RidesListPage _ ->
            True

        RidesCreatePage _ ->
            True

        RideDetailsPage _ _ ->
            True

        RideRequestDetailsPage _ _ _ _ ->
            True


pathParser : Navigation.Location -> Maybe Page
pathParser =
    parseHash pageParser


static : String -> Parser a a
static =
    UrlParser.s
