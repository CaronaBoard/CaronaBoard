module Groups.View.List exposing (list)

import Groups.Model exposing (Group, Model, isMemberOfGroup)
import Groups.Styles exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (id)
import Html.Styled.Events exposing (onClick)
import Layout.Styles exposing (Classes(..), styledLayoutClass)
import Login.Model
import Model as Root exposing (Msg(..))
import RemoteData exposing (..)
import UrlRouter.Model exposing (Msg(..))
import UrlRouter.Routes exposing (Page(..))


list : Login.Model.Model -> Model -> Html Root.Msg
list login model =
    case model.list of
        NotAsked ->
            text ""

        Loading ->
            text "Carregando..."

        Success groups ->
            div []
                [ div [ styledLayoutClass Container ]
                    [ h1 [ styledLayoutClass PageTitle ] [ text "Grupos de Carona" ]
                    ]
                , styled div
                    listContainer
                    []
                    [ styled ul Groups.Styles.list [] (List.map (groupItem login) groups)
                    ]
                ]

        Failure err ->
            text err


groupItem : Login.Model.Model -> Group -> Html Root.Msg
groupItem login group =
    let
        page =
            if isMemberOfGroup login group then
                RidesListPage group.id
            else
                GroupDetailsPage group.id
    in
    li [ id group.id, onClick (MsgForUrlRouter <| Go page) ] [ text group.name ]
