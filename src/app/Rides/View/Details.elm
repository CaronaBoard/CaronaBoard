module Rides.View.Details exposing (details)

import Common.IdentifiedList exposing (findById)
import Common.Response as Response exposing (Response(..))
import Html exposing (..)
import Layout.Styles exposing (Classes(..), layoutClass)
import Model as Root
import RidesRequests.View.New


details : String -> String -> Root.Model -> Html Root.Msg
details groupId rideId model =
    div [ layoutClass Container ]
        [ h1 [ layoutClass PageTitle ] [ text "Pedir Carona" ]
        , case findById rideId (Response.withDefault [] model.rides.list) of
            Just ride ->
                Html.map Root.MsgForRidesRequests <| RidesRequests.View.New.new ride model.ridesRequests

            Nothing ->
                text "Carona não encontrada"
        ]
