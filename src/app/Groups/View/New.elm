module Groups.View.New exposing (new)

import Common.Form exposing (..)
import Groups.Model exposing (..)
import Html exposing (..)
import Html.Events exposing (onSubmit)
import Layout.Styles exposing (Classes(..), layoutClass)


new : Model -> Html Msg
new model =
    div [ layoutClass Container ]
        [ h1 [ layoutClass PageTitle ] [ text "Criar grupo" ]
        , form [ layoutClass Card, onSubmit CreateGroup ]
            (formFields model)
        ]


formFields : Model -> List (Html Msg)
formFields { new } =
    [ renderErrors new.response
    , textInput new.fields.name UpdateName "name" "Nome"
    , loadingOrSubmitButton new.response "submitNewGroup" [ text "Criar" ]
    ]
