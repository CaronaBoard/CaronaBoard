module Integration.NotificationsSpec exposing (tests)

import Expect exposing (equal)
import Helpers exposing (expectToContainText, initialContext, someUser, toLocation)
import Model exposing (Model)
import Msg as Root exposing (Msg(..))
import Test exposing (..)
import Testable.Html.Selectors exposing (..)
import Testable.TestContext exposing (..)
import UrlRouter.Routes exposing (Page(..), toPath)


tests : Test
tests =
    describe "enable notifications" <|
        [ test "shows loading on submit" <|
            enableNotifications
                >> find [ id "enableNotifications" ]
                >> assertText (Expect.equal "Carregando...")
        ]


enableNotifications : a -> TestContext Root.Msg Model
enableNotifications =
    initialContext someUser EnableNotificationsPage
        >> find [ tag "form" ]
        >> trigger "submit" "{}"
