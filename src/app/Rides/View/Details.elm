module Rides.View.Details exposing (details)

import Common.IdentifiedList exposing (findById)
import Html.Styled exposing (..)
import Layout.Styles exposing (Classes(..), styledLayoutClass)
import Model as Root
import RemoteData exposing (..)
import RidesRequests.View.New


details : String -> String -> Root.Model -> Html Root.Msg
details groupId rideId model =
    div [ styledLayoutClass Container ]
        [ h1 [ styledLayoutClass PageTitle ] [ text "Pedir Carona" ]
        , case findById rideId (RemoteData.withDefault [] model.rides.list) of
            Just ride ->
                Html.Styled.map Root.MsgForRidesRequests <| fromUnstyled <| RidesRequests.View.New.new ride model.ridesRequests

            Nothing ->
                text "Carona não encontrada"
        ]
