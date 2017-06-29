module UrlRouter.Update exposing (changePageTo, init, update, urlRouterUpdate)

import GiveRide.Model exposing (Msg(..))
import Login.Model as Login exposing (Msg(..))
import Model as Root exposing (Msg(..))
import Navigation exposing (Location)
import Notifications.Model as Notifications exposing (isEnabled)
import Profile.Model as Profile exposing (Msg(..))
import Testable.Cmd
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


update : Notifications.Model -> Profile.Model -> Login.Model -> Root.Msg -> Model -> ( Model, Testable.Cmd.Cmd UrlRouter.Model.Msg )
update notifications profile login msg model =
    case msg of
        MsgForUrlRouter urlMsg ->
            urlRouterUpdate profile login urlMsg model

        MsgForLogin (SignInResponse ( Nothing, Just _ )) ->
            urlRouterUpdate profile login (Go RidesPage) model

        MsgForLogin (SignOutResponse ( Nothing, Just _ )) ->
            urlRouterUpdate profile login (Go LoginPage) model

        MsgForLogin (PasswordResetResponse ( Nothing, Just _ )) ->
            urlRouterUpdate profile login (Go PasswordResetPage) model

        MsgForGiveRide (GiveRideResponse ( Nothing, Just _ )) ->
            if isEnabled notifications then
                urlRouterUpdate profile login (Go RidesPage) model
            else
                urlRouterUpdate profile login (Go EnableNotificationsPage) model

        MsgForProfile (ProfileResponse ( Nothing, Just _ )) ->
            urlRouterUpdate profile login (Go RidesPage) model

        _ ->
            ( model, Testable.Cmd.none )


urlRouterUpdate : Profile.Model -> Login.Model -> UrlRouter.Model.Msg -> Model -> ( Model, Testable.Cmd.Cmd UrlRouter.Model.Msg )
urlRouterUpdate profile login msg model =
    case msg of
        Go route ->
            ( model, Testable.Cmd.wrap <| Navigation.newUrl (toPath route) )

        UrlChange location ->
            case changePageTo profile login model location of
                Nothing ->
                    ( model, Testable.Cmd.none )

                Just page ->
                    ( { model | page = page }, Testable.Cmd.wrap <| Navigation.modifyUrl (toPath page) )


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
