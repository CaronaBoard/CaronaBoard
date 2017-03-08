module Integration.UrlRouterSpec exposing (tests)

import Test exposing (..)
import Testable.TestContext exposing (..)
import Testable.Html.Selectors exposing (..)
import Testable.Html.Types exposing (Selector)
import Expect exposing (equal)
import Model exposing (Model)
import Update
import Msg as Root exposing (Msg(MsgForUrlRouter, MsgForLogin))
import View
import Login.Msg exposing (Msg(..))
import Login.Ports exposing (signOut)
import Login.Model exposing (User)
import Login.Styles exposing (namespace, Classes(Page))
import Navigation exposing (Location)
import UrlRouter.Msg exposing (Msg(UrlChange))
import UrlRouter.Routes exposing (toPath, Page(SplashScreenPage, RidesPage, LoginPage))
import Css.Helpers exposing (identifierToString)


tests : Test
tests =
    describe "UrlRouter"
        [ describe "initial routing"
            [ test "renders rides page if app starts on login page but user is already logged in" <|
                initialContext (Just someUser) LoginPage
                    >> expectToBeOnRidesPage
            , test "renders login page if app starts on rides page but user is not logged in" <|
                initialContext Nothing RidesPage
                    >> expectToBeOnLoginPage
            ]
        , test "renders login and hides rides when user is not logged in and is on login route" <|
            loginContext
                >> expectToBeOnLoginPage
        , test "redirects user to login page if it is not logged in and goes to home or page" <|
            loginContext
                >> Expect.all
                    [ update (MsgForUrlRouter <| UrlChange (toLocation RidesPage)) >> expectToBeOnLoginPage
                    , update (MsgForUrlRouter <| UrlChange (toLocation SplashScreenPage)) >> expectToBeOnLoginPage
                    ]
        , test "renders rides and hides login when user is logged in and on rides route" <|
            loginContext
                >> update (MsgForLogin <| SignInResponse ( Nothing, Just someUser ))
                >> update (MsgForUrlRouter <| UrlChange (toLocation RidesPage))
                >> expectToBeOnRidesPage
        , test "redirects user to rides page if it is already logged in and goes to login page or home page" <|
            loginContext
                >> update (MsgForLogin <| SignInResponse ( Nothing, Just someUser ))
                >> Expect.all
                    [ update (MsgForUrlRouter <| UrlChange (toLocation LoginPage)) >> expectToBeOnRidesPage
                    , update (MsgForUrlRouter <| UrlChange (toLocation SplashScreenPage)) >> expectToBeOnRidesPage
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
loginContext =
    initialContext Nothing LoginPage


initialContext : Maybe User -> Page -> a -> TestContext Root.Msg Model.Model
initialContext currentUser page _ =
    startForTest
        { init = Model.init { currentUser = currentUser } (toLocation page)
        , update = Update.update
        , view = View.view
        }


loginThenLogout : a -> TestContext Root.Msg Model
loginThenLogout =
    loginContext
        >> update (MsgForLogin <| SignInResponse ( Nothing, Just someUser ))
        >> update (MsgForUrlRouter <| UrlChange (toLocation RidesPage))
        >> find [ id "open-menu-button" ]
        >> trigger "click" "{}"
        >> find [ id "signout-button" ]
        >> trigger "click" "{}"


class : Classes -> Selector
class =
    Testable.Html.Selectors.class << identifierToString namespace


expectToBeOnLoginPage : TestContext msg model -> Expect.Expectation
expectToBeOnLoginPage =
    Expect.all
        [ find [ id "rides-page" ]
            >> assertNodeCount (Expect.equal 0)
        , find [ class Page ]
            >> assertPresent
        ]


expectToBeOnRidesPage : TestContext msg model -> Expect.Expectation
expectToBeOnRidesPage =
    Expect.all
        [ find [ id "rides-page" ]
            >> assertPresent
        , find [ class Page ]
            >> assertNodeCount (Expect.equal 0)
        ]


someUser : User
someUser =
    { id = "foo-bar-bar", name = "Baz" }
