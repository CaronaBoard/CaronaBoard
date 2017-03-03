module Common.CssHelpers exposing (Namespace, withNamespace)

import Html.CssHelpers as CssHelpers
import Testable.Html exposing (Attribute)


type alias Namespace class id msg =
    { scopedId : id -> Attribute msg
    , scopedClass : List class -> Attribute msg
    , scopedClassList : List ( class, Bool ) -> Attribute msg
    , namespace : String
    }


withNamespace : String -> Namespace class id msg
withNamespace namespace =
    let
        { id, class, classList, name } =
            CssHelpers.withNamespace namespace
    in
        { scopedId = id, scopedClass = class, scopedClassList = classList, namespace = name }
