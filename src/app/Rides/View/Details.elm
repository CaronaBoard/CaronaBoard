module Rides.View.Details exposing (details)

import Common.IdentifiedList exposing (findById)
import Html.Styled exposing (..)
import Layout.Styles exposing (..)
import Model as Root
import RemoteData exposing (..)
import RidesRequests.View.New


details : String -> String -> Root.Model -> Html Root.Msg
details groupId rideId model =
    styled div
        container
        []
        [ styled h1 pageTitle [] [ text "Pedir Carona" ]
        , case findById rideId (RemoteData.withDefault [] model.rides.list) of
            Just ride ->
                Html.Styled.map Root.MsgForRidesRequests <| RidesRequests.View.New.new ride model.ridesRequests

            Nothing ->
                text "Carona não encontrada"
        ]
