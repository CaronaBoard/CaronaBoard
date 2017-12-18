module Integration.RidesSpec exposing (tests)

import Expect exposing (equal)
import Helpers exposing (expectCurrentPage, expectToContainText, fixtures, initialContext, signedInContext, someUser, toLocation)
import Integration.GroupsSpec exposing (loadGroups)
import JsonStringify exposing (simpleStringify)
import Model as Root exposing (Model, Msg(..))
import Notifications.Model exposing (Msg(..))
import RemoteData exposing (RemoteData(..))
import Rides.Model exposing (Msg(..))
import Rides.Ports exposing (..)
import Test exposing (..)
import Test.Html.Event exposing (input, submit)
import Test.Html.Query exposing (..)
import Test.Html.Selector exposing (..)
import TestContext exposing (..)
import UrlRouter.Routes exposing (Page(..), toPath)


tests : Test
tests =
    describe "Rides" <|
        [ describe "list" <|
            [ test "renders no routes when there are no rides loaded yet" <|
                ridesListContext
                    >> TestContext.expectView
                    >> findAll [ id "rideItem" ]
                    >> count (Expect.equal 0)
            , test "request rides list when going to the page" <|
                ridesListContext
                    >> expectCmd (ridesList ())
            , test "shows loading when the rides are loading" <|
                ridesListContext
                    >> expectView
                    >> has [ text "Carregando..." ]
            , test "renders rides when they load" <|
                ridesListContext
                    >> loadGroups
                    >> loadRides
                    >> expectView
                    >> findAll [ id "rideItem" ]
                    >> count (Expect.equal 2)
            , test "renders only the rides for the selected group" <|
                ridesListContext
                    >> loadGroups
                    >> loadRides
                    >> navigate (toPath <| RidesListPage "idGroup2")
                    >> expectView
                    >> findAll [ id "rideItem" ]
                    >> count (Expect.equal 0)
            ]
        , describe "new" <|
            [ test "fill the fields correctly" <|
                fillNewRide
                    >> expectView
                    >> find [ id "origin" ]
                    >> has [ attribute "defaultValue" "bar" ]
            , test "shows loading on submit" <|
                submitNewRide
                    >> expectView
                    >> find [ id "submitNewRide" ]
                    >> has [ text "Carregando..." ]
            , test "sends request via createRide port" <|
                submitNewRide
                    >> expectCmd (Cmd.map MsgForRides <| Rides.Ports.createRide fixtures.newRide)
            , test "shows error when createRide port returns an error" <|
                submitNewRide
                    >> update (MsgForRides <| CreateRideResponse (Failure "Scientists just proved that undefined is indeed not a function"))
                    >> expectView
                    >> has [ text "not a function" ]
            , test "goes to enable notifications page on success" <|
                submitNewRide
                    >> successResponse
                    >> expectCurrentPage EnableNotificationsPage
            , test "goes to the groups page on success if notifications are already enabled" <|
                submitNewRide
                    >> update (MsgForNotifications <| NotificationsResponse (Success True))
                    >> successResponse
                    >> expectCurrentPage GroupsListPage
            , test "shows notification on success" <|
                submitNewRide
                    >> successResponse
                    >> expectView
                    >> has [ text "Carona criada com sucesso!" ]
            , test "clear fields on success after returning to the form" <|
                submitNewRide
                    >> successResponse
                    >> navigate (toPath <| RidesCreatePage "idGroup1")
                    >> expectView
                    >> find [ id "origin" ]
                    >> has [ attribute "defaultValue" "" ]
            ]
        ]


loadRides : TestContext model msg -> TestContext model msg
loadRides =
    send ridesListResponse ( Nothing, Just <| simpleStringify { idGroup1 = { idUser1 = { idRide1 = fixtures.ride1 }, idUser2 = { idRide2 = fixtures.ride2 } } } )


ridesListContext : a -> TestContext Model Root.Msg
ridesListContext =
    signedInContext (RidesListPage "idGroup1")


ridesCreateContext : a -> TestContext Model Root.Msg
ridesCreateContext =
    signedInContext (RidesCreatePage "idGroup1")


fillNewRide : a -> TestContext Model Root.Msg
fillNewRide =
    ridesCreateContext
        >> simulate (find [ id "origin" ]) (input fixtures.newRide.origin)
        >> simulate (find [ id "destination" ]) (input fixtures.newRide.destination)
        >> simulate (find [ id "days" ]) (input fixtures.newRide.days)
        >> simulate (find [ id "hours" ]) (input fixtures.newRide.hours)


submitNewRide : a -> TestContext Model Root.Msg
submitNewRide =
    fillNewRide
        >> simulate (find [ tag "form" ]) submit


successResponse : TestContext Model Root.Msg -> TestContext Model Root.Msg
successResponse =
    update (MsgForRides <| CreateRideResponse (Success True))
