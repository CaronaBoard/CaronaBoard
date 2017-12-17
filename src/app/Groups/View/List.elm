module Groups.View.List exposing (list)

import Groups.Model exposing (Group, Model, isMemberOfGroup)
import Groups.Styles exposing (Classes(..), className)
import Html exposing (..)
import Html.Attributes exposing (id)
import Html.Events exposing (onClick)
import Layout.Styles exposing (Classes(..), layoutClass)
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
                [ div [ layoutClass Container ]
                    [ h1 [ layoutClass PageTitle ] [ text "Grupos de Carona" ]
                    ]
                , div [ className ListContainer ]
                    [ ul [ className List ] (List.map (groupItem login) groups)
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
