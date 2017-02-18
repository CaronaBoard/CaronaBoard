module Layout.SplashScreen exposing (splashScreen)

import Testable.Html exposing (Html, div)
import Testable.Html.Attributes exposing (id)
import Msg exposing (Msg(..))


splashScreen : Html Msg
splashScreen =
    div [ id "splash-screen" ] []
