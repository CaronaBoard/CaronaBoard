module Groups.View exposing (groupsList)

import Common.CssHelpers exposing (materializeClass)
import Common.Response exposing (Response(..))
import Groups.Model exposing (Group, Model)
import Groups.Styles exposing (Classes(..), className)
import Html exposing (..)
import Layout.Styles exposing (Classes(..), layoutClass)


groupsList : Model -> Html msg
groupsList model =
    case model.groups of
        Empty ->
            text ""

        Loading ->
            text "Carregando..."

        Success groups ->
            div []
                [ div [ materializeClass "container" ]
                    [ h1 [ layoutClass PageTitle ] [ text "Groupos de Carona" ]
                    ]
                , ul [ className List ] (List.map groupItem groups)
                ]

        Error err ->
            text err


groupItem : Group -> Html msg
groupItem group =
    li [] [ text group.name ]
