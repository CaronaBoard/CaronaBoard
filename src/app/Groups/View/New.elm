module Groups.View.New exposing (new)

import Common.Form exposing (..)
import Groups.Model exposing (..)
import Html exposing (..)
import Layout.Styles exposing (Classes(..), layoutClass)


new : Model -> Html Msg
new model =
    div [ layoutClass Container ]
        [ h1 [ layoutClass PageTitle ] [ text "Criar grupo" ]
        , form [ layoutClass Card ]
            (formFields model)
        ]


formFields : Model -> List (Html Msg)
formFields { new } =
    [ textInput new.fields.name UpdateName "name" "Nome"
    ]
