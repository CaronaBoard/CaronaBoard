module UrlRouter.Update exposing (changePageTo, init, update, urlRouterUpdate)

import Common.Response exposing (..)
import Groups.Model exposing (Msg(..))
import Login.Model as Login exposing (Msg(..))
import Model as Root exposing (Msg(..))
import Navigation exposing (Location)
import Notifications.Model as Notifications exposing (Msg(..), isEnabled)
import Profile.Model as Profile exposing (Msg(..))
import RemoteData exposing (..)
import Return exposing (Return, return)
import Rides.Model exposing (Msg(..))
import UrlRouter.Model exposing (Model, Msg(..))
import UrlRouter.Routes exposing (Page(..), pathParser, redirectTo, requiresAuthentication, toPath)


init : Location -> Model
init location =
    case pathParser location of
        Nothing ->
            { page = SplashScreenPage
            , returnTo = Nothing
            }

        Just page ->
            { page = page, returnTo = Nothing }


update : Root.Msg -> Root.Model -> Return UrlRouter.Model.Msg Model
update msg { notifications, profile, login, urlRouter } =
    case msg of
        MsgForUrlRouter urlMsg ->
            urlRouterUpdate profile login urlMsg urlRouter

        MsgForLogin (CheckRegistrationResponse (Success True)) ->
            urlRouterUpdate profile login (Go PasswordStepPage) urlRouter

        MsgForLogin (CheckRegistrationResponse (Success False)) ->
            urlRouterUpdate profile login (Go RegistrationPage) urlRouter

        MsgForLogin (SignInResponse (Success _)) ->
            urlRouterUpdate profile login (Go urlRouter.page) urlRouter

        MsgForLogin (SignOutResponse (Success _)) ->
            urlRouterUpdate profile login (Go LoginPage) urlRouter

        MsgForLogin (PasswordResetResponse (Success _)) ->
            urlRouterUpdate profile login (Go PasswordResetPage) urlRouter

        MsgForRides (CreateRideResponse (Success _)) ->
            if isEnabled notifications then
                urlRouterUpdate profile login (Go GroupsListPage) urlRouter
            else
                urlRouterUpdate profile login (Go EnableNotificationsPage) urlRouter

        MsgForProfile (ProfileResponse (Success _)) ->
            urlRouterUpdate profile login (Go GroupsListPage) urlRouter

        MsgForNotifications (NotificationsResponse (Success _)) ->
            urlRouterUpdate profile login (Go GroupsListPage) urlRouter

        MsgForGroups (CreateGroupResponse (Success _)) ->
            urlRouterUpdate profile login (Go GroupsListPage) urlRouter

        _ ->
            return urlRouter Cmd.none


urlRouterUpdate : Profile.Model -> Login.Model -> UrlRouter.Model.Msg -> Model -> Return UrlRouter.Model.Msg Model
urlRouterUpdate profile login msg model =
    case msg of
        Go route ->
            ( model, Navigation.newUrl (toPath route) )

        UrlChange location ->
            changePageTo profile login model location

        Back ->
            return model (Navigation.back 1)


changePageTo : Profile.Model -> Login.Model -> Model -> Location -> Return UrlRouter.Model.Msg Model
changePageTo profile login model location =
    let
        requestedPage =
            Maybe.withDefault NotFoundPage (pathParser location)

        pageAfterRedirect =
            redirectTo model.returnTo profile login requestedPage

        shouldModifyUrl =
            requestedPage /= pageAfterRedirect

        returnTo =
            if shouldModifyUrl && requiresAuthentication requestedPage then
                Just requestedPage
            else
                model.returnTo

        navigationCmd =
            if shouldModifyUrl then
                Navigation.modifyUrl <| toPath pageAfterRedirect
            else
                Cmd.none
    in
    return { model | page = pageAfterRedirect, returnTo = returnTo } navigationCmd
