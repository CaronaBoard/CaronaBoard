module Common.CssHelpers exposing (Namespace, materializeClass, namespacedClass)

import Html.CssHelpers as CssHelpers
import Testable.Html exposing (Attribute)
import Testable.Html.Attributes


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
    Testable.Html.Attributes.class
