module Integration.LayoutSpec exposing (tests)

import Expect exposing (equal)
import Helpers exposing (expectToContainText, expectToNotContainText, initialContext, signedInContext, someUser)
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
                >> findAll [ id "menu" ]
                >> count (Expect.equal 0)
        , test "opens the dropdown on click" <|
            layoutContext
                >> simulate (find [ id "openMenu" ]) click
                >> expectView
                >> findAll [ id "menu" ]
                >> count (Expect.equal 1)
        , test "closes the dropdown when clicking outside" <|
            layoutContext
                >> simulate (find [ id "openMenu" ]) click
                >> simulate (find [ id "menu" ]) click
                >> expectView
                >> findAll [ id "menu" ]
                >> count (Expect.equal 0)
        , test "does not have a back button on groups page" <|
            layoutContext
                >> navigate (toPath GroupsListPage)
                >> expectView
                >> findAll [ id "navBack" ]
                >> count (Expect.equal 0)
        , test "has a back button when on others pages" <|
            layoutContext
                >> navigate (toPath GroupsListPage)
                >> navigate (toPath ProfilePage)
                >> simulate (find [ id "navBack" ]) click
                >> expectModel
                    (\model ->
                        model.urlRouter.page
                            |> Expect.equal GroupsListPage
                    )
        ]


layoutContext : a -> TestContext Model Root.Msg
layoutContext =
    signedInContext GroupsListPage
