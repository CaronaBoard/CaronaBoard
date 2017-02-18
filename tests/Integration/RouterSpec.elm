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
import UrlRouter.Routes exposing (toPath, Page(HomeRoute, RidesRoute, LoginRoute))


tests : Test
tests =
    describe "Layout"
        [ test "renders login and hides rides when user is not logged in and is on login route" <|
            loginContext
                >> expectToBeOnLoginPage
        , test "redirects user to login page if it is not logged in and goes to home or page" <|
            loginContext
                >> Expect.all
                    [ update (MsgForUrlRouter <| UrlChange (toLocation RidesRoute)) >> expectToBeOnLoginPage
                    , update (MsgForUrlRouter <| UrlChange (toLocation HomeRoute)) >> expectToBeOnLoginPage
                    ]
        , test "renders rides and hides login when user is logged in and on rides route" <|
            loginContext
                >> update (MsgForLogin <| SignInResponse ( Nothing, Just { id = "foo-bar-baz", name = "Baz" } ))
                >> update (MsgForUrlRouter <| UrlChange (toLocation RidesRoute))
                >> expectToBeOnRidesPage
        , test "redirects user to rides page if it is already logged in and goes to login page or home page" <|
            loginContext
                >> update (MsgForLogin <| SignInResponse ( Nothing, Just { id = "foo-bar-baz", name = "Baz" } ))
                >> Expect.all
                    [ update (MsgForUrlRouter <| UrlChange (toLocation LoginRoute)) >> expectToBeOnRidesPage
                    , update (MsgForUrlRouter <| UrlChange (toLocation HomeRoute)) >> expectToBeOnRidesPage
                    ]
        , describe "logout"
            [ test "trigger port on sign out button click" <|
                loginThenLogout
                    >> assertCalled (Cmd.map MsgForLogin <| signOut ())
            , test "does not log user out until the response from firebase" <|
                loginThenLogout
                    >> expectToBeOnRidesPage
            ]
        ]


toLocation : Page -> Location
toLocation page =
    { href = "", host = "", hostname = "", protocol = "", origin = "", port_ = "", pathname = "", search = "", hash = toPath page, username = "", password = "" }


loginContext : a -> TestContext Root.Msg Model.Model
loginContext _ =
    startForTest
        { init = Model.init { currentUser = Nothing } (toLocation LoginRoute)
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


expectToBeOnLoginPage : TestContext msg model -> Expect.Expectation
expectToBeOnLoginPage =
    Expect.all
        [ find [ id "app-main" ]
            >> assertNodeCount (Expect.equal 0)
        , find [ id "app-login" ]
            >> assertPresent
        ]


expectToBeOnRidesPage : TestContext msg model -> Expect.Expectation
expectToBeOnRidesPage =
    Expect.all
        [ find [ id "app-main" ]
            >> assertPresent
        , find [ id "app-login" ]
            >> assertNodeCount (Expect.equal 0)
        ]
