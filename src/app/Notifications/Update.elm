module Notifications.Update exposing (update)

import Common.Response exposing (Response(..), fromFirebase)
import Msg as Root exposing (Msg(..))
import Notifications.Model exposing (Model)
import Notifications.Msg exposing (Msg(..))
import Notifications.Ports exposing (enableNotifications)
import Testable.Cmd


update : Root.Msg -> Model -> ( Model, Testable.Cmd.Cmd Notifications.Msg.Msg )
update msg model =
    case msg of
        MsgForNotifications msg_ ->
            updateNotifications msg_ model

        _ ->
            ( model, Testable.Cmd.none )


updateNotifications : Notifications.Msg.Msg -> Model -> ( Model, Testable.Cmd.Cmd Notifications.Msg.Msg )
updateNotifications msg model =
    case msg of
        EnableNotifications ->
            ( { model | response = Loading }, Testable.Cmd.wrap <| enableNotifications () )

        NotificationsResponse response ->
            ( { model | response = fromFirebase response }, Testable.Cmd.none )
