module Profile.View exposing (profile)

import Common.Form exposing (..)
import Form exposing (Form)
import Html.Styled exposing (..)
import Html.Styled.Events exposing (onInput, onSubmit)
import Layout.Styles exposing (..)
import Profile.Model exposing (Model, Msg(..), Profile, contactIdentifier)
import Profile.Styles exposing (..)


profile : Model -> Html Msg
profile model =
    containerElem []
        [ pageTitle []
            [ if model.savedProfile == Nothing then
                text "Criar Perfil"
              else
                text "Editar Perfil"
            ]
        , Html.Styled.map FormMsg (formFields model)
        ]


formFields : Model -> Html Form.Msg
formFields { response, fields } =
    styled form
        card
        [ onSubmit Form.Submit ]
        [ renderErrors response
        , p [] [ text "Você precisa preencher seus dados de contato para poder dar ou pedir carona. Essa é a forma que os outros entrarão em contato com você." ]
        , br [] []
        , textInput fields "name" "Nome"
        , contactField []
            [ contactKind []
                [ selectInput fields
                    "contactKind"
                    [ ( "Whatsapp", "Whatsapp" )
                    , ( "Telegram", "Telegram" )
                    ]
                ]
            , contactValue []
                [ textInput fields
                    "contactValue"
                    (Form.getFieldAsString "contactKind" fields
                        |> .value
                        |> Maybe.withDefault ""
                        |> contactIdentifier
                    )
                ]
            ]
        , loadingOrSubmitButton response "submitProfile" [ text "Salvar" ]
        ]
