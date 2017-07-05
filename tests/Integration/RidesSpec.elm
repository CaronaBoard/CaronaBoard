module Integration.RidesSpec exposing (tests)

import Css.Helpers exposing (identifierToString)
import Expect exposing (equal)
import Helpers exposing (expectToContainText, fixtures, initialContext, signedInContext, someUser, toLocation)
import JsonStringify exposing (simpleStringify)
import Model as Root exposing (Model, Msg(..))
import Rides.Ports exposing (..)
import Rides.Styles exposing (Classes(Card))
import Test exposing (..)
import Test.Html.Query exposing (..)
import Test.Html.Selector exposing (..)
import TestContext exposing (..)
import UrlRouter.Routes exposing (Page(..))


tests : Test
tests =
    describe "Rides"
        [ test "renders no routes when there are no rides loaded yet" <|
            ridesContext
                >> TestContext.expectView
                >> findAll [ class Card ]
                >> count (Expect.equal 0)
        , test "request rides list when going to the page" <|
            ridesContext
                >> expectCmd (ridesList ())
        , test "shows loading when the rides are loading" <|
            ridesContext
                >> expectView
                >> has [ text "Carregando..." ]
        , test "renders rides when they load" <|
            ridesContext
                >> send ridesListResponse ( Nothing, Just <| simpleStringify { idGroup1 = { idUser1 = { idRide1 = fixtures.ride1 }, idUser2 = { idRide2 = fixtures.ride2 } } } )
                >> expectView
                >> findAll [ class Card ]
                >> count (Expect.equal 2)
        ]


ridesContext : a -> TestContext Model Root.Msg
ridesContext =
    signedInContext (RidesPage "idGroup1")


class : Classes -> Test.Html.Selector.Selector
class =
    Test.Html.Selector.class << identifierToString Rides.Styles.namespace
