module Notifications.Update exposing (init, update)

import Common.Response exposing (Response(..))
import GiveRide.Model exposing (Msg(..))
import Model as Root exposing (Msg(..))
import Notifications.Model exposing (Model, Msg(..))
import Notifications.Ports exposing (enableNotifications)
import Process
import Profile.Model exposing (Msg(..))
import Rides.Model exposing (Msg(..))
import Rides.Ride.Model exposing (Msg(..))
import Task
import Time


init : Model
init =
    { response = Empty
    , notice = Nothing
    }


update : Root.Msg -> Model -> ( Model, Cmd.Cmd Notifications.Model.Msg )
update msg model =
    case msg of
        MsgForNotifications msg_ ->
            updateNotifications msg_ model

        MsgForGiveRide (GiveRideResponse (Success _)) ->
            updateNotifications (ShowNotice "Carona criada com sucesso!") model

        MsgForRides (MsgForRide _ (RideRequestResponse (Success _))) ->
            updateNotifications (ShowNotice "Pedido de carona enviado com sucesso!") model

        MsgForProfile (ProfileResponse (Success _)) ->
            updateNotifications (ShowNotice "Perfil atualizado com sucesso") model

        _ ->
            ( model, Cmd.none )


updateNotifications : Notifications.Model.Msg -> Model -> ( Model, Cmd.Cmd Notifications.Model.Msg )
updateNotifications msg model =
    case msg of
        EnableNotifications ->
            ( { model | response = Loading }, enableNotifications () )

        NotificationsResponse response ->
            ( { model | response = response }, Cmd.none )

        ShowNotice notice ->
            ( { model | notice = Just notice }
            , Process.sleep (3 * Time.second)
                |> Task.perform (always HideNotice)
            )

        HideNotice ->
            ( { model | notice = Nothing }, Cmd.none )
