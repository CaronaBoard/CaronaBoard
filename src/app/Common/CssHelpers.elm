module Common.CssHelpers exposing (..)

import Html exposing (Attribute)
import Html.CssHelpers as CssHelpers
import Html.Styled
import Html.Styled.Attributes


type alias Namespace class msg =
    { class : class -> Attribute msg
    , namespace : String
    }


namespacedClass : String -> (class -> Attribute msg)
namespacedClass namespace =
    let
        { class, name } =
            CssHelpers.withNamespace namespace
    in
    \name -> class [ name ]


styledNamespacedClass : String -> (class -> Html.Styled.Attribute msg)
styledNamespacedClass namespace =
    let
        { class, name } =
            CssHelpers.withNamespace namespace
    in
    \name ->
        class [ name ]
            |> Html.Styled.Attributes.fromUnstyled
