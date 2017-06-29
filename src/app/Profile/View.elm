module Profile.View exposing (profile)

import Common.CssHelpers exposing (materializeClass)
import Common.Form exposing (loadingOrSubmitButton, renderErrors, textInput)
import Layout.Styles exposing (Classes(..), layoutClass)
import Profile.Model exposing (Model, contactIdentifier)
import Profile.Msg exposing (Msg(..))
import Profile.Styles exposing (Classes(..), className)
import Testable.Html exposing (..)
import Testable.Html.Attributes exposing (for, href, id, placeholder, selected, target, value)
import Testable.Html.Events exposing (onInput, onSubmit)


profile : Model -> Html Msg
profile model =
    div [ materializeClass "container" ]
        [ h1 [ layoutClass PageTitle ]
            [ if model.savedProfile == Nothing then
                text "Criar Perfil"
              else
                text "Editar Perfil"
            ]
        , form [ materializeClass "card", onSubmit Submit ]
            [ div [ materializeClass "card-content" ]
                (formFields model)
            ]
        ]


formFields : Model -> List (Html Msg)
formFields model =
    [ renderErrors model.response
    , p [] [ text "Você precisa preencher seus dados de contato para poder dar ou pedir carona. Essa é a forma que os outros entrarão em contato com você." ]
    , br [] []
    , textInput model.fields.name UpdateName "name" "Seu nome"
    , div [ className ContactField ]
        [ div [ materializeClass "input-field", className ContactKind ]
            [ div [ materializeClass "select-wrapper" ]
                [ span [ materializeClass "caret" ] [ text "▼" ]
                , select [ className Select, onInput UpdateContactKind, id "contactKind" ]
                    [ contactKindOption model "Whatsapp"
                    , contactKindOption model "Telegram"
                    ]
                ]
            ]
        , div [ className ContactValue ]
            [ textInput model.fields.contact.value UpdateContactValue "contactValue" (contactIdentifier model.fields.contact.kind) ]
        ]
    , loadingOrSubmitButton model.response [ id "submitProfile", layoutClass SubmitButton ] [ text "Salvar" ]
    ]


contactKindOption : Model -> String -> Html msg
contactKindOption model value_ =
    option [ value value_, selected (model.fields.contact.value == value_) ] [ text value_ ]
