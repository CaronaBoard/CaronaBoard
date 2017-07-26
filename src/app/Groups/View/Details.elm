module Groups.View.Details exposing (details)

import Common.IdentifiedList exposing (findById)
import Common.Response as Response exposing (Response(..))
import Html exposing (..)
import Layout.Styles exposing (Classes(..), layoutClass)
import Model as Root exposing (Msg(..))


details : String -> Root.Model -> Html Msg
details groupId { groups } =
    case groups.groups of
        Empty ->
            text "TODO: fetch groups"

        Loading ->
            text "Carregando..."

        Success groups ->
            case findById groupId groups of
                Just group ->
                    div [ layoutClass Container ]
                        [ h1 [ layoutClass PageTitle ] [ text group.name ]
                        , text "Você não faz parte desse grupo. [Participar do grupo]"
                        ]

                Nothing ->
                    h1 [] [ text "404 não encontrado" ]

        Error err ->
            text err
