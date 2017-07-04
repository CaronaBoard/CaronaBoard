module Integration.GroupsSpec exposing (tests)

import Helpers exposing (expectToContainText, fixtures, initialContext, signedInContext, someUser, toLocation)
import Model as Root exposing (Model, Msg(..))
import Test exposing (..)
import Test.Html.Query exposing (..)
import Test.Html.Selector exposing (..)
import TestContext exposing (..)
import UrlRouter.Routes exposing (Page(..))


tests : Test
tests =
    describe "Groups"
        [ test "shows loading when the groups are loading" <|
            groupsContext
                >> expectView
                >> has [ text "Carregando..." ]
        ]


groupsContext : a -> TestContext Model Root.Msg
groupsContext =
    signedInContext GroupsPage
