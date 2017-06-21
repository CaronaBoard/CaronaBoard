module Integration.UrlRouterSpec exposing (tests)

import Css.Helpers exposing (identifierToString)
import Expect exposing (equal)
import Layout.Styles exposing (Classes(OpenMenuButton, SignOutButton))
import Login.Model exposing (User)
import Login.Msg exposing (Msg(..))
import Login.Ports exposing (signOut)
import Login.Styles
import Model exposing (Model)
import Msg as Root exposing (Msg(MsgForLogin, MsgForUrlRouter))
import Navigation exposing (Location)
import Rides.Styles
import Test exposing (..)
import Testable.Html.Selectors exposing (..)
import Testable.Html.Types exposing (Selector)
import Testable.TestContext exposing (..)
import Update
import UrlRouter.Msg exposing (Msg(UrlChange))
import UrlRouter.Routes exposing (Page(LoginPage, RidesPage, SplashScreenPage), toPath)
import View


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


layoutClass : Layout.Styles.Classes -> Selector
layoutClass =
    Testable.Html.Selectors.class << identifierToString Layout.Styles.namespace


loginClass : Login.Styles.Classes -> Selector
loginClass =
    Testable.Html.Selectors.class << identifierToString Login.Styles.namespace


ridesClass : Rides.Styles.Classes -> Selector
ridesClass =
    Testable.Html.Selectors.class << identifierToString Rides.Styles.namespace


loginThenLogout : a -> TestContext Root.Msg Model
loginThenLogout =
    loginContext
        >> update (MsgForLogin <| SignInResponse ( Nothing, Just someUser ))
        >> update (MsgForUrlRouter <| UrlChange (toLocation RidesPage))
        >> find [ layoutClass OpenMenuButton ]
        >> trigger "click" "{}"
        >> find [ layoutClass SignOutButton ]
        >> trigger "click" "{}"


expectToBeOnLoginPage : TestContext msg model -> Expect.Expectation
expectToBeOnLoginPage =
    Expect.all
        [ find [ ridesClass Rides.Styles.Page ]
            >> assertNodeCount (Expect.equal 0)
        , find [ loginClass Login.Styles.Page ]
            >> assertPresent
        ]


expectToBeOnRidesPage : TestContext msg model -> Expect.Expectation
expectToBeOnRidesPage =
    Expect.all
        [ find [ ridesClass Rides.Styles.Page ]
            >> assertPresent
        , find [ loginClass Login.Styles.Page ]
            >> assertNodeCount (Expect.equal 0)
        ]


someUser : User
someUser =
    { id = "foo-bar-bar", name = "Baz" }
