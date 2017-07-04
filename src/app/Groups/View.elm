module Groups.View exposing (groupsList)

import Common.Response exposing (Response(..))
import Groups.Model exposing (Group, Model)
import Html exposing (..)


groupsList : Model -> Html msg
groupsList model =
    case model.groups of
        Empty ->
            text ""

        Loading ->
            text "Carregando..."

        Success groups ->
            ul [] (List.map groupItem groups)

        Error err ->
            text err


groupItem : Group -> Html msg
groupItem group =
    li [] [ text group.name ]
