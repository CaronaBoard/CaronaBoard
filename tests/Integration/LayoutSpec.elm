module Integration.LayoutSpec exposing (tests)

import Css.Helpers exposing (identifierToString)
import Expect exposing (equal)
import Helpers exposing (expectToContainText, expectToNotContainText, initialContext, signedInContext, someUser)
import Layout.Styles exposing (Classes(..))
import Model as Root exposing (Model, Msg(MsgForLayout))
import Test exposing (..)
import Test.Html.Event exposing (click)
import Test.Html.Query exposing (..)
import Test.Html.Selector exposing (..)
import TestContext exposing (..)
import UrlRouter.Routes exposing (Page(..), toPath)


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
                >> simulate (find [ id "openMenu" ]) click
                >> expectView
                >> findAll [ class Menu ]
                >> count (Expect.equal 1)
        , test "closes the dropdown when clicking outside" <|
            layoutContext
                >> simulate (find [ id "openMenu" ]) click
                >> simulate (find [ class Menu ]) click
                >> expectView
                >> findAll [ class Menu ]
                >> count (Expect.equal 0)
        , test "does not have a back button on groups page" <|
            layoutContext
                >> navigate (toPath GroupsPage)
                >> expectView
                >> findAll [ class NavBack ]
                >> count (Expect.equal 0)
        , test "has a back button when on others pages" <|
            layoutContext
                >> navigate (toPath GroupsPage)
                >> navigate (toPath ProfilePage)
                >> simulate (find [ class NavBack ]) click
                >> expectModel
                    (\model ->
                        model.urlRouter.page
                            |> Expect.equal GroupsPage
                    )
        ]


layoutContext : a -> TestContext Model Root.Msg
layoutContext =
    signedInContext GroupsPage


class : Classes -> Selector
class =
    Test.Html.Selector.class << identifierToString Layout.Styles.namespace
