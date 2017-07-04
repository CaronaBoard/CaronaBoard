module Integration.GroupsSpec exposing (tests)

import Expect
import Groups.Ports exposing (groupsResponse)
import Helpers exposing (expectToContainText, fixtures, initialContext, jsonQuotes, signedInContext, someUser, toLocation)
import JsonStringify exposing (simpleStringify)
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
        , test "renders groups when they load" <|
            groupsContext
                >> send groupsResponse (simpleStringify { idGroup1 = fixtures.group1, idGroup2 = fixtures.group2 })
                >> expectView
                >> Expect.all
                    [ has [ tag "li", text "winona riders" ]
                    , has [ tag "li", text "the uber killars" ]
                    ]
        ]


groupsContext : a -> TestContext Model Root.Msg
groupsContext =
    signedInContext GroupsPage
