module Integration.LayoutSpec exposing (tests)

import Css.Helpers exposing (identifierToString)
import Expect exposing (equal)
import Layout.Model exposing (Model, init)
import Layout.Styles exposing (Classes(Menu, OpenMenuButton))
import Layout.Update as Update
import Layout.View.Header exposing (header)
import Msg as Root exposing (Msg(MsgForLayout))
import Test exposing (..)
import Testable.Cmd
import Testable.Html.Selectors exposing (..)
import Testable.Html.Types exposing (Selector)
import Testable.TestContext exposing (..)


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
layoutContext _ =
    startForTest
        { init = ( init, Testable.Cmd.none )
        , update = \msg model -> Tuple.mapSecond (Testable.Cmd.map MsgForLayout) <| Update.update msg model
        , view = header
        }


class : Classes -> Selector
class =
    Testable.Html.Selectors.class << identifierToString Layout.Styles.namespace
