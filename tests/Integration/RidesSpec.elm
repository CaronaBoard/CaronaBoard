module Integration.RidesSpec exposing (tests)

import Css.Helpers exposing (identifierToString)
import Expect exposing (equal)
import Helpers exposing (expectToContainText, fixtures, initialContext, signedInContext, someUser, toLocation)
import Model as Root exposing (Model, Msg(..))
import Rides.Model exposing (Msg(..))
import Rides.Styles exposing (Classes(Card))
import Test exposing (..)
import Test.Html.Query exposing (..)
import Test.Html.Selector
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
        , test "renders routes when they load" <|
            ridesContext
                >> update (MsgForRides <| UpdateRides fixtures.rides)
                >> TestContext.expectView
                >> findAll [ class Card ]
                >> count (Expect.equal 2)
        ]


ridesContext : a -> TestContext Model Root.Msg
ridesContext =
    signedInContext RidesPage


class : Classes -> Test.Html.Selector.Selector
class =
    Test.Html.Selector.class << identifierToString Rides.Styles.namespace
