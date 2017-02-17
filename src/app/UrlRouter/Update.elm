module UrlRouter.Update exposing (..)

import Login.Model as Login
import UrlRouter.Model exposing (Model)
import UrlRouter.Msg exposing (Msg(..))
import UrlRouter.Routes exposing (Page(NotFound), pathParser, toPath, redirectTo)
import Testable.Cmd
import Navigation exposing (Location)


update : Msg -> Model -> Login.Model -> Model
update msg model login =
    case msg of
        Go _ ->
            model

        UrlChange location ->
            case changePageTo model login location of
                Nothing ->
                    model

                Just page ->
                    { model | page = page }


cmdUpdate : Msg -> Model -> Login.Model -> Testable.Cmd.Cmd Msg
cmdUpdate msg model login =
    case msg of
        Go route ->
            Testable.Cmd.wrap <| Navigation.newUrl (toPath route)

        UrlChange location ->
            case changePageTo model login location of
                Nothing ->
                    Testable.Cmd.none

                Just page ->
                    Testable.Cmd.wrap <| Navigation.modifyUrl (toPath page)


changePageTo : Model -> Login.Model -> Location -> Maybe Page
changePageTo model login location =
    let
        requestedPage =
            Maybe.withDefault NotFound (pathParser location)

        pageAfterRedirect =
            redirectTo login requestedPage

        shouldChangeUrl =
            (model.page /= requestedPage) || (model.page /= pageAfterRedirect)
    in
        if shouldChangeUrl then
            Just pageAfterRedirect
        else
            Nothing
