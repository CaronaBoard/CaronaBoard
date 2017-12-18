module Profile.View exposing (profile)

import Common.Form exposing (..)
import Form exposing (Form)
import Html.Styled exposing (..)
import Html.Styled.Events exposing (onInput, onSubmit)
import Layout.Styles exposing (Classes(..), styledLayoutClass)
import Profile.Model exposing (Model, Msg(..), Profile, contactIdentifier)
import Profile.Styles exposing (..)


profile : Model -> Html Msg
profile model =
    div [ styledLayoutClass Container ]
        [ h1 [ styledLayoutClass PageTitle ]
            [ if model.savedProfile == Nothing then
                text "Criar Perfil"
              else
                text "Editar Perfil"
            ]
        , Html.Styled.map FormMsg (formFields model)
        ]


formFields : Model -> Html Form.Msg
formFields { response, fields } =
    form [ styledLayoutClass Card, onSubmit Form.Submit ]
        [ fromUnstyled <| renderErrors response
        , p [] [ text "Você precisa preencher seus dados de contato para poder dar ou pedir carona. Essa é a forma que os outros entrarão em contato com você." ]
        , br [] []
        , fromUnstyled <| textInput fields "name" "Nome"
        , styled div
            contactField
            []
            [ styled div
                contactKind
                []
                [ fromUnstyled <|
                    selectInput fields
                        "contactKind"
                        [ ( "Whatsapp", "Whatsapp" )
                        , ( "Telegram", "Telegram" )
                        ]
                ]
            , styled div
                contactValue
                []
                [ fromUnstyled <|
                    textInput fields
                        "contactValue"
                        (Form.getFieldAsString "contactKind" fields
                            |> .value
                            |> Maybe.withDefault ""
                            |> contactIdentifier
                        )
                ]
            ]
        , styledLoadingOrSubmitButton response "submitProfile" [ text "Salvar" ]
        ]
