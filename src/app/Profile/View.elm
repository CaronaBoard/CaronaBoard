module Profile.View exposing (profile)

import Common.CssHelpers exposing (materializeClass)
import Common.Form exposing (loadingOrSubmitButton, renderErrors, textInput)
import Layout.Styles exposing (Classes(..))
import Profile.Model exposing (Model)
import Profile.Msg exposing (Msg(..))
import Profile.Styles exposing (Classes(..), class)
import Rides.Model exposing (contactDeepLink, contactIdentifier)
import Testable.Html exposing (..)
import Testable.Html.Attributes exposing (for, href, id, placeholder, selected, target, value)
import Testable.Html.Events exposing (onInput, onSubmit)


layoutClass : class -> Attribute msg
layoutClass =
    Layout.Styles.class


profile : Model -> Html Msg
profile model =
    div [ materializeClass "container" ]
        [ h1 [ layoutClass PageTitle ] [ text "Editar Perfil" ]
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
    , div [ class ContactField ]
        [ div [ materializeClass "input-field" ]
            [ div [ materializeClass "select-wrapper" ]
                [ span [ materializeClass "caret" ] [ text "▼" ]
                , select [ materializeClass "browser-default", onInput UpdateContactType, id "contactType" ]
                    [ contactTypeOption model "Whatsapp"
                    , contactTypeOption model "Telegram"
                    ]
                ]
            ]
        , textInput model.fields.contact.value UpdateContactValue "contactValue" (contactIdentifier model.fields.contact.kind)
        ]
    , loadingOrSubmitButton model.response [ id "submitProfile", layoutClass SubmitButton ] [ text "Salvar" ]
    ]


contactTypeOption : Model -> String -> Html msg
contactTypeOption model value_ =
    option [ value value_, selected (model.fields.contact.value == value_) ] [ text value_ ]
