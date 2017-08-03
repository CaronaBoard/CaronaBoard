module Groups.View.Details exposing (details)

import Common.Form exposing (loadingOrSubmitButton)
import Common.IdentifiedList exposing (findById)
import Common.Response as Response exposing (Response(..))
import Groups.Model exposing (Msg(..))
import Html exposing (..)
import Html.Attributes exposing (disabled)
import Html.Events exposing (..)
import Layout.Styles exposing (Classes(..), layoutClass)
import Model as Root exposing (Msg(..))


details : String -> Root.Model -> Html Root.Msg
details groupId { groups } =
    case groups.groups of
        Empty ->
            text ""

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
        , form [ layoutClass Card, onSubmit (MsgForGroups <| CreateJoinGroupRequest group.id) ]
            [ p [] [ text "Este grupo é um grupo fechado, clique abaixo para pedir autorização dos administradores para entrar no grupo." ]
            , br [] []
            , case group.joinRequest of
                Success _ ->
                    button [ disabled True, layoutClass DisabledButton ]
                        [ div [ layoutClass ButtonContainer ] [ text "Pedido enviado!" ] ]

                _ ->
                    loadingOrSubmitButton group.joinRequest "joinGroup" [ text "Participar do grupo" ]
            ]
        ]
