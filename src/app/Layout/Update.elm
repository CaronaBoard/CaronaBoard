module Layout.Update exposing (init, update)

import Layout.Model exposing (Model, Msg(..))
import Model as Root exposing (Msg(..))
import Return exposing (Return, return)


init : Model
init =
    { dropdownOpen = False
    }


update : Root.Msg -> Model -> Return Layout.Model.Msg Model
update msg model =
    case msg of
        MsgForLayout layoutMsg ->
            updateLayout layoutMsg model

        _ ->
            return model Cmd.none


updateLayout : Layout.Model.Msg -> Model -> Return Layout.Model.Msg Model
updateLayout msg model =
    case msg of
        OpenDropdown ->
            return { model | dropdownOpen = True } Cmd.none

        CloseDropdown ->
            return { model | dropdownOpen = False } Cmd.none
