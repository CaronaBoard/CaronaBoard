module UrlRouter.Update exposing (update, urlRouterUpdate, changePageTo)

import Login.Model as Login
import UrlRouter.Model exposing (Model)
import UrlRouter.Msg exposing (Msg(Go, UrlChange))
import UrlRouter.Routes exposing (Page(NotFoundPage, RidesPage, LoginPage, PasswordResetPage), pathParser, toPath, redirectTo)
import Testable.Cmd
import Navigation exposing (Location)
import Msg as Root exposing (Msg(MsgForUrlRouter, MsgForLogin))
import Login.Msg exposing (Msg(SignInResponse, SignOutResponse, PasswordResetResponse))


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
