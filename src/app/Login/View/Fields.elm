module Login.View.Fields exposing (..)

import Html exposing (Attribute, Html, button, div, i, input, label, span, text)
import Html.Attributes exposing (disabled, for, id, placeholder, type_, value)
import Html.Events exposing (onInput)
import Layout.Styles exposing (Classes(..), layoutClass)


emailInput : String -> (String -> msg) -> String -> String -> Html msg
emailInput =
    input_ "email"


passwordInput : String -> (String -> msg) -> String -> String -> Html msg
passwordInput =
    input_ "password"


input_ : String -> String -> (String -> msg) -> String -> String -> Html msg
input_ inputType value_ msg id_ label_ =
    div [ layoutClass InputField ]
        [ input
            [ id id_
            , type_ inputType
            , value value_
            , placeholder " "
            , onInput msg
            ]
            []
        , label [ for id_ ] [ text label_ ]
        ]
