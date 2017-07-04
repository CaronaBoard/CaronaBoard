module Groups.Update exposing (init, update)

import Common.Response exposing (Response(..))
import Groups.Model as Groups exposing (Model, Msg(..))
import Model as Root exposing (Msg(..))
import Return exposing (Return, return)


init : Model
init =
    { groups = Loading }


update : Root.Msg -> Model -> Return Groups.Msg Model
update msg model =
    case msg of
        MsgForGroups msg_ ->
            updateGroups msg_ model

        _ ->
            return model Cmd.none


updateGroups : Groups.Msg -> Model -> Return Groups.Msg Model
updateGroups msg model =
    case msg of
        UpdateGroups response ->
            return { model | groups = response } Cmd.none
