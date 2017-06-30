module Common.CssHelpers exposing (Namespace, materializeClass, namespacedClass)

import Html exposing (Attribute)
import Html.Attributes
import Html.CssHelpers as CssHelpers


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


materializeClass : String -> Attribute msg
materializeClass =
    Html.Attributes.class
