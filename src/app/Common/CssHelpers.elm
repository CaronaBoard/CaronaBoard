module Common.CssHelpers exposing (..)

import Html
import Html.CssHelpers as CssHelpers
import Html.Styled


type alias Namespace class msg =
    { class : class -> Html.Attribute msg
    , namespace : String
    }


type alias StyledElement msg =
    List (Html.Styled.Attribute msg) -> List (Html.Styled.Html msg) -> Html.Styled.Html msg


namespacedClass : String -> (class -> Html.Attribute msg)
namespacedClass namespace =
    let
        { class, name } =
            CssHelpers.withNamespace namespace
    in
    \name -> class [ name ]
