module Integration.LayoutSpec exposing (tests)

import Css.Helpers exposing (identifierToString)
import Expect exposing (equal)
import Helpers exposing (expectToContainText, expectToNotContainText, initialContext, signedInContext, someUser)
import Layout.Styles exposing (Classes(Menu, OpenMenuButton))
import Model as Root exposing (Model, Msg(MsgForLayout))
import Test exposing (..)
import Test.Html.Events as Events exposing (Event(..))
import Test.Html.Query exposing (..)
import Test.Html.Selector exposing (..)
import TestContext exposing (..)
import UrlRouter.Routes exposing (Page(..))


tests : Test
tests =
    describe "Layout"
        [ test "starts with the dropdown in the header closed" <|
            layoutContext
                >> expectView
                >> findAll [ class Menu ]
                >> count (Expect.equal 0)
        , test "opens the dropdown on click" <|
            layoutContext
                >> simulate (find [ class OpenMenuButton ]) Events.Click
                >> expectView
                >> findAll [ class Menu ]
                >> count (Expect.equal 1)
        , test "closes the dropdown when clicking outside" <|
            layoutContext
                >> simulate (find [ class OpenMenuButton ]) Events.Click
                >> simulate (find [ class Menu ]) Events.Click
                >> expectView
                >> findAll [ class Menu ]
                >> count (Expect.equal 0)
        ]


layoutContext : a -> TestContext Model Root.Msg
layoutContext =
    signedInContext RidesPage


class : Classes -> Selector
class =
    Test.Html.Selector.class << identifierToString Layout.Styles.namespace
