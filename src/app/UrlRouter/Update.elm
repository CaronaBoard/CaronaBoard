module UrlRouter.Update exposing (..)

import Login.Model as Login
import UrlRouter.Model exposing (Model)
import UrlRouter.Msg exposing (Msg(..))
import UrlRouter.Routes exposing (Page, pathParser, toPath, redirectTo)
import Testable.Cmd
import Navigation exposing (Location)


update : Msg -> Model -> Login.Model -> Model
update msg model login =
    case msg of
        Go _ ->
            model

        UrlChange location ->
            case locationWithRedirect login location of
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
            case locationWithRedirect login location of
                Nothing ->
                    Testable.Cmd.none

                Just page ->
                    if page /= model.page then
                        Testable.Cmd.wrap <| Navigation.modifyUrl (toPath page)
                    else
                        Testable.Cmd.none


locationWithRedirect : Login.Model -> Location -> Maybe Page
locationWithRedirect login location =
    pathParser location
        |> Maybe.map (redirectTo login)
