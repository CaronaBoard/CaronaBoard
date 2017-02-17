module Integration.LayoutSpec exposing (..)

import Test exposing (..)
import Testable.TestContext exposing (..)
import Testable.Html.Selectors exposing (..)
import Expect exposing (equal)
import Update
import Model
import Msg
import Login.Msg
import Login.Ports exposing (signOut)
import View exposing (homeLocation)


loginContext : a -> TestContext Msg.Msg Model.Model
loginContext _ =
    startForTest
        { init = Model.init { currentUser = Nothing } homeLocation
        , update = Update.update
        , view = View.view
        }


loginThenLogout : a -> TestContext Msg.Msg Model.Model
loginThenLogout =
    loginContext
        >> update (Msg.MsgForLogin <| Login.Msg.SignInResponse ( Nothing, Just { id = "foo-bar-baz", name = "Baz" } ))
        >> find [ id "signout-button" ]
        >> trigger "click" "{}"


tests : Test
tests =
    describe "Layout"
        [ test "renders login and hides home when user is logged out" <|
            loginContext
                >> Expect.all
                    [ find [ id "app-main" ]
                        >> assertNodeCount (Expect.equal 0)
                    , find [ id "app-login" ]
                        >> assertPresent
                    ]
        , test "renders home and hides login when user loggs in" <|
            loginContext
                >> update (Msg.MsgForLogin <| Login.Msg.SignInResponse ( Nothing, Just { id = "foo-bar-baz", name = "Baz" } ))
                >> Expect.all
                    [ find [ id "app-main" ]
                        >> assertPresent
                    , find [ id "app-login" ]
                        >> assertNodeCount (Expect.equal 0)
                    ]
        , describe "logout"
            [ test "trigger port on sign out button click" <|
                loginThenLogout
                    >> assertCalled (Cmd.map Msg.MsgForLogin <| signOut ())
            , test "does not log user out until the response from firebase" <|
                loginThenLogout
                    >> Expect.all
                        [ find [ id "app-main" ]
                            >> assertPresent
                        , find [ id "app-login" ]
                            >> assertNodeCount (Expect.equal 0)
                        ]
            , test "goes back to login page on logout" <|
                loginThenLogout
                    >> update (Msg.MsgForLogin Login.Msg.SignOutResponse)
                    >> Expect.all
                        [ find [ id "app-main" ]
                            >> assertNodeCount (Expect.equal 0)
                        , find [ id "app-login" ]
                            >> assertPresent
                        ]
            ]
        ]
