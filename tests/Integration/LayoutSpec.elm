module Integration.LayoutSpec exposing (..)

import Test exposing (..)
import Testable.TestContext exposing (..)
import Testable.Html.Selectors exposing (..)
import Expect exposing (equal)
import Update
import Model
import View
import Msg
import Login.Msg


loginContext : a -> TestContext Msg.Msg Model.Model
loginContext _ =
    startForTest
        { init = Model.init
        , update = Update.update
        , view = View.view
        }


tests : Test
tests =
    describe "Layout"
        [ test "renders login and hides home when user is logged out"
            <| loginContext
            >> Expect.all
                [ find [ id "app-main" ]
                    >> assertNodeCount (Expect.equal 0)
                , find [ id "app-login" ]
                    >> assertPresent
                ]
        , test "renders home and hides login when user loggs in"
            <| loginContext
            >> update (Msg.MsgForLogin <| Login.Msg.SignInResponse ( Nothing, Just { id = "foo-bar-baz", name = "Baz" } ))
            >> Expect.all
                [ find [ id "app-main" ]
                    >> assertPresent
                , find [ id "app-login" ]
                    >> assertNodeCount (Expect.equal 0)
                ]
        ]
