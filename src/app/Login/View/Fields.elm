module Login.View.Fields exposing (..)

import Html.Styled exposing (Attribute, Html, button, div, i, input, label, span, styled, text)
import Html.Styled.Attributes exposing (disabled, for, id, placeholder, type_, value)
import Html.Styled.Events exposing (onInput)
import Layout.Styles exposing (Classes(..), layoutClass)
import Login.Styles exposing (..)


emailInput : String -> (String -> msg) -> String -> String -> Html msg
emailInput =
    input_ "email"


passwordInput : String -> (String -> msg) -> String -> String -> Html msg
passwordInput =
    input_ "password"


input_ : String -> String -> (String -> msg) -> String -> String -> Html msg
input_ inputType value_ msg id_ label_ =
    div [ layoutClass InputField ]
        [ styled input
            stepInput
            [ id id_
            , type_ inputType
            , value value_
            , placeholder " "
            , onInput msg
            ]
            []
        , label [ for id_ ] [ text label_ ]
        ]
