module Groups.View.Details exposing (details)

import Common.IdentifiedList exposing (findById)
import Common.Response as Response exposing (Response(..))
import Groups.Model exposing (Msg(..))
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Layout.Styles exposing (Classes(..), layoutClass)
import Model as Root exposing (Msg(..))


details : String -> Root.Model -> Html Root.Msg
details groupId { groups } =
    case groups.groups of
        Empty ->
            text "TODO: fetch groups"

        Loading ->
            text "Carregando..."

        Success groups ->
            case findById groupId groups of
                Just group ->
                    renderGroup group

                Nothing ->
                    h1 [] [ text "404 não encontrado" ]

        Error err ->
            text err


renderGroup : Groups.Model.Group -> Html Root.Msg
renderGroup group =
    div [ layoutClass Container ]
        [ h1 [ layoutClass PageTitle ] [ text group.name ]
        , text "Você não faz parte desse grupo."
        , button
            [ id "joinGroup"
            , onClick <| MsgForGroups <| CreateJoinGroupRequest group.id
            ]
            [ text "Participar do grupo" ]
        , case group.joinRequest of
            Empty ->
                text ""

            Loading ->
                text "Carregando..."

            Success _ ->
                text "Pedido enviado!"

            Error err ->
                text err
        ]
