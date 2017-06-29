module Layout.Update exposing (init, update)

import Layout.Model exposing (Model, Msg(..))
import Model as Root exposing (Msg(..))
import Testable.Cmd


init : Model
init =
    { dropdownOpen = False
    }


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
