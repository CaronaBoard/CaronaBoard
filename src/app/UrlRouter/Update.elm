module UrlRouter.Update exposing (changePageTo, update, urlRouterUpdate)

import GiveRide.Msg exposing (Msg(..))
import Login.Model as Login
import Login.Msg exposing (Msg(..))
import Msg as Root exposing (Msg(..))
import Navigation exposing (Location)
import Testable.Cmd
import UrlRouter.Model exposing (Model)
import UrlRouter.Msg exposing (Msg(Go, UrlChange))
import UrlRouter.Routes exposing (Page(..), pathParser, redirectTo, toPath)


update : Root.Msg -> Model -> Login.Model -> ( Model, Testable.Cmd.Cmd UrlRouter.Msg.Msg )
update msg model login =
    case msg of
        MsgForUrlRouter urlMsg ->
            urlRouterUpdate urlMsg model login

        MsgForLogin (SignInResponse ( Nothing, Just _ )) ->
            urlRouterUpdate (Go RidesPage) model login

        MsgForLogin SignOutResponse ->
            urlRouterUpdate (Go LoginPage) model login

        MsgForLogin (PasswordResetResponse Nothing) ->
            urlRouterUpdate (Go PasswordResetPage) model login

        MsgForGiveRide (GiveRideResponse ( Nothing, Just _ )) ->
            urlRouterUpdate (Go RidesPage) model login

        _ ->
            ( model, Testable.Cmd.none )


urlRouterUpdate : UrlRouter.Msg.Msg -> Model -> Login.Model -> ( Model, Testable.Cmd.Cmd UrlRouter.Msg.Msg )
urlRouterUpdate msg model login =
    case msg of
        Go route ->
            ( model, Testable.Cmd.wrap <| Navigation.newUrl (toPath route) )

        UrlChange location ->
            case changePageTo model login location of
                Nothing ->
                    ( model, Testable.Cmd.none )

                Just page ->
                    ( { model | page = page }, Testable.Cmd.wrap <| Navigation.modifyUrl (toPath page) )


changePageTo : Model -> Login.Model -> Location -> Maybe Page
changePageTo model login location =
    let
        requestedPage =
            Maybe.withDefault NotFoundPage (pathParser location)

        pageAfterRedirect =
            redirectTo login requestedPage

        shouldChangeUrl =
            (model.page /= requestedPage) || (model.page /= pageAfterRedirect)
    in
    if shouldChangeUrl then
        Just pageAfterRedirect
    else
        Nothing
