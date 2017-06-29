module Layout.Update exposing (update)

import Layout.Model exposing (Model, Msg(..))
import Msg as Root exposing (Msg(..))
import Testable.Cmd


update : Root.Msg -> Model -> ( Model, Testable.Cmd.Cmd Layout.Model.Msg )
update msg model =
    case msg of
        MsgForLayout layoutMsg ->
            updateLayout layoutMsg model

        _ ->
            ( model, Testable.Cmd.none )


updateLayout : Layout.Model.Msg -> Model -> ( Model, Testable.Cmd.Cmd Layout.Model.Msg )
updateLayout msg model =
    case msg of
        OpenDropdown ->
            ( { model | dropdownOpen = True }, Testable.Cmd.none )

        CloseDropdown ->
            ( { model | dropdownOpen = False }, Testable.Cmd.none )
