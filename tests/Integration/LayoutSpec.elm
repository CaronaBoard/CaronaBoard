module Integration.LayoutSpec exposing (..)

import Test exposing (..)
import Testable.TestContext exposing (..)
import Testable.Html.Selectors exposing (..)
import Expect exposing (equal)
import Layout.Update as Update
import Layout.Model exposing (Model, init)
import Layout.Header exposing (header)
import Testable.Cmd
import Msg as Root exposing (Msg(MsgForLayout))


layoutContext : a -> TestContext Root.Msg Model
layoutContext _ =
    startForTest
        { init = ( init, Testable.Cmd.none )
        , update = (\msg model -> Tuple.mapSecond (Testable.Cmd.map MsgForLayout) <| Update.update msg model)
        , view = header
        }


tests : Test
tests =
    describe "Layout"
        [ test "starts with the dropdown in the header closed" <|
            layoutContext
                >> findAll [ id "menu" ]
                >> assertNodeCount (Expect.equal 0)
        , test "opens the dropdown on click" <|
            layoutContext
                >> find [ id "open-menu-button" ]
                >> trigger "click" "{}"
                >> find [ id "menu" ]
                >> assertPresent
        , test "closes the dropdown when clicking outside" <|
            layoutContext
                >> find [ id "open-menu-button" ]
                >> trigger "click" "{}"
                >> find [ id "menu" ]
                >> trigger "click" "{}"
                >> findAll [ id "menu" ]
                >> assertNodeCount (Expect.equal 0)
        ]
