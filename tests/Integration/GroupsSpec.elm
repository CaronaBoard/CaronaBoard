module Integration.GroupsSpec exposing (tests)

import Expect
import Groups.Ports exposing (..)
import Helpers exposing (expectToContainText, fixtures, initialContext, jsonQuotes, signedInContext, someUser, toLocation)
import JsonStringify exposing (simpleStringify)
import Model as Root exposing (Model, Msg(..))
import Test exposing (..)
import Test.Html.Event exposing (click)
import Test.Html.Query exposing (..)
import Test.Html.Selector exposing (..)
import TestContext exposing (..)
import UrlRouter.Routes exposing (Page(..), toPath)


tests : Test
tests =
    describe "Groups"
        [ test "request groups list when going to the page" <|
            groupsContext
                >> expectCmd (groupsList ())
        , test "shows loading when the groups are loading" <|
            groupsContext
                >> expectView
                >> has [ text "Carregando..." ]
        , test "renders groups when they load" <|
            groupsContext
                >> loadGroups
                >> expectView
                >> Expect.all
                    [ has [ tag "li", text "winona riders" ]
                    , has [ tag "li", text "the uber killars" ]
                    ]
        , test "goes the the group's rides when clicking on it" <|
            groupsContext
                >> loadGroups
                >> simulate (find [ id "idGroup1" ]) click
                >> expectModel
                    (\model ->
                        Expect.equal (RidesListPage "idGroup1") model.urlRouter.page
                    )
        , test "goes to a page requesting to join the group if the user is not a member" <|
            groupsContext
                >> loadGroups
                >> simulate (find [ id "idGroup2" ]) click
                >> expectView
                >> has [ text "Participar do grupo" ]
        , describe "details"
            [ test "shows loading when the groups are loading" <|
                groupsContext
                    >> navigate (toPath <| GroupDetailsPage "idGroup2")
                    >> expectView
                    >> has [ text "Carregando..." ]
            , test "renders group details after loading" <|
                groupsContext
                    >> navigate (toPath <| GroupDetailsPage "idGroup2")
                    >> loadGroups
                    >> expectView
                    >> has [ text fixtures.group2.name ]
            , test "renders a 404 if the group was not found" <|
                groupsContext
                    >> navigate (toPath <| GroupDetailsPage "nan")
                    >> loadGroups
                    >> expectView
                    >> has [ text "404 não encontrado" ]
            ]
        ]


loadGroups : TestContext model msg -> TestContext model msg
loadGroups =
    send groupsListResponse ( Nothing, Just <| simpleStringify { idGroup1 = fixtures.group1, idGroup2 = fixtures.group2 } )


groupsContext : a -> TestContext Model Root.Msg
groupsContext =
    signedInContext GroupsListPage
