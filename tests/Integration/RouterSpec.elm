module Integration.RouterSpec exposing (..)

import Test exposing (..)
import Testable.TestContext exposing (..)
import Testable.Html.Selectors exposing (..)
import Expect exposing (equal)
import Model exposing (Model)
import Update
import Msg as Root exposing (Msg(MsgForUrlRouter, MsgForLogin))
import View
import Login.Msg exposing (Msg(..))
import Login.Ports exposing (signOut)
import Navigation exposing (Location)
import UrlRouter.Msg exposing (Msg(UrlChange))
import UrlRouter.Routes exposing (toPath, Page(HomeRoute, RidesRoute))


toLocation : Page -> Location
toLocation page =
    { href = "", host = "", hostname = "", protocol = "", origin = "", port_ = "", pathname = "", search = "", hash = toPath page, username = "", password = "" }


loginContext : a -> TestContext Root.Msg Model.Model
loginContext _ =
    startForTest
        { init = Model.init { currentUser = Nothing } (toLocation HomeRoute)
        , update = Update.update
        , view = View.view
        }


loginThenLogout : a -> TestContext Root.Msg Model
loginThenLogout =
    loginContext
        >> update (MsgForLogin <| SignInResponse ( Nothing, Just { id = "foo-bar-baz", name = "Baz" } ))
        >> update (MsgForUrlRouter <| UrlChange (toLocation RidesRoute))
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
                >> update (MsgForLogin <| SignInResponse ( Nothing, Just { id = "foo-bar-baz", name = "Baz" } ))
                >> Expect.all
                    [ find [ id "app-main" ]
                        >> assertPresent
                    , find [ id "app-login" ]
                        >> assertNodeCount (Expect.equal 0)
                    ]
        , describe "logout"
            [ test "trigger port on sign out button click" <|
                loginThenLogout
                    >> assertCalled (Cmd.map MsgForLogin <| signOut ())
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
                    >> update (MsgForLogin SignOutResponse)
                    >> Expect.all
                        [ find [ id "app-main" ]
                            >> assertNodeCount (Expect.equal 0)
                        , find [ id "app-login" ]
                            >> assertPresent
                        ]
            ]
        ]
