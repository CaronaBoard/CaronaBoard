module Router.Update exposing (..)

import Router.Msg exposing (Msg(..))
import Router.Model exposing (Model)
import Router.Routes exposing (pathParser, toPath)
import Testable.Cmd
import Navigation


update : Msg -> Model -> Model
update msg model =
    case msg of
        Go _ ->
            model

        UrlChange location ->
            case pathParser location of
                Nothing ->
                    model

                Just page ->
                    { page = page }


cmdUpdate : Msg -> Model -> Testable.Cmd.Cmd Msg
cmdUpdate msg model =
    case msg of
        Go route ->
            Testable.Cmd.wrap <| Navigation.newUrl (toPath route)

        UrlChange location ->
            case pathParser location of
                Nothing ->
                    Testable.Cmd.wrap <| Navigation.modifyUrl (toPath model.page)

                Just page ->
                    Testable.Cmd.none
