module UrlRouter.Update exposing (changePageTo, update, urlRouterUpdate)

import GiveRide.Msg exposing (Msg(..))
import Login.Model as Login
import Login.Msg exposing (Msg(..))
import Msg as Root exposing (Msg(..))
import Navigation exposing (Location)
import Notifications.Model as Notifications exposing (isEnabled)
import Profile.Model as Profile
import Profile.Msg exposing (Msg(..))
import Testable.Cmd
import UrlRouter.Model exposing (Model)
import UrlRouter.Msg exposing (Msg(Go, UrlChange))
import UrlRouter.Routes exposing (Page(..), pathParser, redirectTo, toPath)


update : Notifications.Model -> Profile.Model -> Login.Model -> Root.Msg -> Model -> ( Model, Testable.Cmd.Cmd UrlRouter.Msg.Msg )
update notifications profile login msg model =
    case msg of
        MsgForUrlRouter urlMsg ->
            urlRouterUpdate profile login urlMsg model

        MsgForLogin (SignInResponse ( Nothing, Just _ )) ->
            urlRouterUpdate profile login (Go RidesPage) model

        MsgForLogin SignOutResponse ->
            urlRouterUpdate profile login (Go LoginPage) model

        MsgForLogin (PasswordResetResponse Nothing) ->
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


urlRouterUpdate : Profile.Model -> Login.Model -> UrlRouter.Msg.Msg -> Model -> ( Model, Testable.Cmd.Cmd UrlRouter.Msg.Msg )
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
