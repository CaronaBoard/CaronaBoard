module Groups.Update exposing (init, update)

import Common.Response exposing (Response(..))
import Groups.Model as Groups exposing (Model, Msg(..))
import Groups.Ports exposing (groupsList)
import Model as Root exposing (Msg(..))
import Return exposing (Return, return)
import UrlRouter.Model exposing (Msg(..))
import UrlRouter.Routes exposing (Page(..), pathParser)


init : Model
init =
    { groups = Empty }


update : Root.Msg -> Model -> Return Groups.Msg Model
update msg model =
    case msg of
        MsgForGroups msg_ ->
            updateGroups msg_ model

        MsgForUrlRouter (UrlChange location) ->
            if model.groups == Empty && pathParser location == Just GroupsListPage then
                return { model | groups = Loading } (groupsList ())
            else
                return model Cmd.none

        _ ->
            return model Cmd.none


updateGroups : Groups.Msg -> Model -> Return Groups.Msg Model
updateGroups msg model =
    case msg of
        UpdateGroups response ->
            return { model | groups = response } Cmd.none
