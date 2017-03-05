module Common.CssHelpers exposing (Namespace, withNamespace, materializeClass, cssClass)

import Css
import Html.CssHelpers as CssHelpers
import Testable.Html exposing (Attribute)
import Testable.Html.Attributes


type alias Namespace class msg =
    { class : class -> Attribute msg
    , classes : List class -> Attribute msg
    , namespace : String
    }


withNamespace : String -> Namespace class msg
withNamespace namespace =
    let
        { class, name } =
            CssHelpers.withNamespace namespace
    in
        { class = (\name -> class [ name ]), classes = class, namespace = name }


materializeClass : String -> Attribute msg
materializeClass =
    Testable.Html.Attributes.class


cssClass : class -> List Css.Mixin -> Css.Snippet
cssClass =
    Css.class
