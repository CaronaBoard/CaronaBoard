module Profile.View exposing (profile)

import Common.Form exposing (..)
import Form exposing (Form)
import Html exposing (..)
import Html.Events exposing (onInput, onSubmit)
import Layout.Styles exposing (Classes(..), layoutClass)
import Profile.Model exposing (Model, Msg(..), Profile, contactIdentifier)
import Profile.Styles exposing (Classes(..), className)


profile : Model -> Html Msg
profile model =
    div [ layoutClass Container ]
        [ h1 [ layoutClass PageTitle ]
            [ if model.savedProfile == Nothing then
                text "Criar Perfil"
              else
                text "Editar Perfil"
            ]
        , Html.map FormMsg (formFields model)
        ]


formFields : Model -> Html Form.Msg
formFields { response, fields } =
    form [ layoutClass Card, onSubmit Form.Submit ]
        [ renderErrors response
        , p [] [ text "Você precisa preencher seus dados de contato para poder dar ou pedir carona. Essa é a forma que os outros entrarão em contato com você." ]
        , br [] []
        , textInput fields "name" "Nome"
        , div [ className ContactField ]
            [ div [ className ContactKind ]
                [ selectInput fields
                    "contactKind"
                    [ ( "Whatsapp", "Whatsapp" )
                    , ( "Telegram", "Telegram" )
                    ]
                ]
            , div [ className ContactValue ]
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
