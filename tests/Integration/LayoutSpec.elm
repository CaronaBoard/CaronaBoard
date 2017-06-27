module Integration.LayoutSpec exposing (tests)

import Css.Helpers exposing (identifierToString)
import Expect exposing (equal)
import Helpers exposing (expectToContainText, expectToNotContainText, initialContext, signedInContext, someUser)
import Layout.Styles exposing (Classes(Menu, OpenMenuButton))
import Model exposing (Model)
import Msg as Root exposing (Msg(MsgForLayout))
import Test exposing (..)
import Testable.Html.Selectors exposing (..)
import Testable.Html.Types exposing (Selector)
import Testable.TestContext exposing (..)
import UrlRouter.Routes exposing (Page(..))


tests : Test
tests =
    describe "Layout"
        [ test "starts with the dropdown in the header closed" <|
            layoutContext
                >> findAll [ class Menu ]
                >> assertNodeCount (Expect.equal 0)
        , test "opens the dropdown on click" <|
            layoutContext
                >> find [ class OpenMenuButton ]
                >> trigger "click" "{}"
                >> find [ class Menu ]
                >> assertPresent
        , test "closes the dropdown when clicking outside" <|
            layoutContext
                >> find [ class OpenMenuButton ]
                >> trigger "click" "{}"
                >> find [ class Menu ]
                >> trigger "click" "{}"
                >> findAll [ class Menu ]
                >> assertNodeCount (Expect.equal 0)
        ]


layoutContext : a -> TestContext Root.Msg Model
layoutContext =
    signedInContext RidesPage


class : Classes -> Selector
class =
    Testable.Html.Selectors.class << identifierToString Layout.Styles.namespace
