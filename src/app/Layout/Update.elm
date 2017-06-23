module Layout.Update exposing (update)

import GiveRide.Msg exposing (Msg(..))
import Layout.Model exposing (Model)
import Layout.Msg exposing (Msg(..))
import Msg as Root exposing (Msg(..))
import Testable.Cmd
import Testable.Process as Process
import Testable.Task as Task
import Time


update : Root.Msg -> Model -> ( Model, Testable.Cmd.Cmd Layout.Msg.Msg )
update msg model =
    case msg of
        MsgForLayout layoutMsg ->
            updateLayout layoutMsg model

        MsgForGiveRide (GiveRideResponse ( Nothing, Just _ )) ->
            updateLayout (ShowNotification "Carona criada com sucesso!") model

        _ ->
            ( model, Testable.Cmd.none )


updateLayout : Layout.Msg.Msg -> Model -> ( Model, Testable.Cmd.Cmd Layout.Msg.Msg )
updateLayout msg model =
    case msg of
        OpenDropdown ->
            ( { model | dropdownOpen = True }, Testable.Cmd.none )

        CloseDropdown ->
            ( { model | dropdownOpen = False }, Testable.Cmd.none )

        ShowNotification notification ->
            ( { model | notification = Just notification }
            , Process.sleep (3 * Time.second)
                |> Task.perform (always HideNotification)
            )

        HideNotification ->
            ( { model | notification = Nothing }, Testable.Cmd.none )
