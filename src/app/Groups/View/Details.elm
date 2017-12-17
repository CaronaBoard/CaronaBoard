module Groups.View.Details exposing (details)

import Common.Form exposing (..)
import Common.IdentifiedList exposing (findById)
import Groups.Model exposing (Msg(..))
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (disabled)
import Html.Styled.Events exposing (..)
import Layout.Styles exposing (Classes(..), styledLayoutClass)
import Model as Root exposing (Msg(..))
import RemoteData exposing (..)


details : String -> Root.Model -> Html Root.Msg
details groupId { groups } =
    case groups.list of
        NotAsked ->
            text ""

        Loading ->
            text "Carregando..."

        Success groups ->
            case findById groupId groups of
                Just group ->
                    renderGroup group

                Nothing ->
                    h1 [] [ text "404 não encontrado" ]

        Failure err ->
            text err


renderGroup : Groups.Model.Group -> Html Root.Msg
renderGroup group =
    div [ styledLayoutClass Container ]
        [ h1 [ styledLayoutClass PageTitle ] [ text group.name ]
        , form [ styledLayoutClass Card, onSubmit (MsgForGroups <| CreateJoinGroupRequest group.id) ]
            [ p [] [ text "Este grupo é um grupo fechado, clique abaixo para pedir autorização dos administradores para entrar no grupo." ]
            , br [] []
            , case group.joinRequest of
                Success _ ->
                    button [ disabled True, styledLayoutClass DisabledButton ]
                        [ div [ styledLayoutClass ButtonContainer ] [ text "Pedido enviado!" ] ]

                _ ->
                    styledLoadingOrSubmitButton group.joinRequest "joinGroup" [ text "Participar do grupo" ]
            ]
        ]
