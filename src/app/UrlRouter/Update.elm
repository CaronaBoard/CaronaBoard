module UrlRouter.Update exposing (changePageTo, init, update, urlRouterUpdate)

import Common.Response exposing (Response(..))
import GiveRide.Model exposing (Msg(..))
import Login.Model as Login exposing (Msg(..))
import Model as Root exposing (Msg(..))
import Navigation exposing (Location)
import Notifications.Model as Notifications exposing (isEnabled)
import Profile.Model as Profile exposing (Msg(..))
import Return exposing (Return, return)
import UrlRouter.Model exposing (Model, Msg(Go, UrlChange))
import UrlRouter.Routes exposing (Page(..), pathParser, redirectTo, toPath)


init : Location -> Model
init location =
    case pathParser location of
        Nothing ->
            { page = SplashScreenPage
            }

        Just page ->
            { page = page }


update : Notifications.Model -> Profile.Model -> Login.Model -> Root.Msg -> Model -> Return UrlRouter.Model.Msg Model
update notifications profile login msg model =
    case msg of
        MsgForUrlRouter urlMsg ->
            urlRouterUpdate profile login urlMsg model

        MsgForLogin (SignInResponse (Success _)) ->
            urlRouterUpdate profile login (Go RidesPage) model

        MsgForLogin (SignOutResponse (Success _)) ->
            urlRouterUpdate profile login (Go LoginPage) model

        MsgForLogin (PasswordResetResponse (Success _)) ->
            urlRouterUpdate profile login (Go PasswordResetPage) model

        MsgForGiveRide (GiveRideResponse (Success _)) ->
            if isEnabled notifications then
                urlRouterUpdate profile login (Go RidesPage) model
            else
                urlRouterUpdate profile login (Go EnableNotificationsPage) model

        MsgForProfile (ProfileResponse (Success _)) ->
            urlRouterUpdate profile login (Go RidesPage) model

        _ ->
            return model Cmd.none


urlRouterUpdate : Profile.Model -> Login.Model -> UrlRouter.Model.Msg -> Model -> Return UrlRouter.Model.Msg Model
urlRouterUpdate profile login msg model =
    case msg of
        Go route ->
            ( model, Navigation.newUrl (toPath route) )

        UrlChange location ->
            case changePageTo profile login model location of
                Nothing ->
                    return model Cmd.none

                Just page ->
                    return { model | page = page } (Navigation.modifyUrl (toPath page))


changePageTo : Profile.Model -> Login.Model -> Model -> Location -> Maybe Page
changePageTo profile login model location =
    let
        requestedPage =
            Maybe.withDefault NotFoundPage (pathParser location)

        pageAfterRedirect =
            redirectTo profile login requestedPage

        shouldChangeUrl =
            (model.page /= requestedPage) || (model.page /= pageAfterRedirect)
    in
    if shouldChangeUrl then
        Just pageAfterRedirect
    else
        Nothing
