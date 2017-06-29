module Integration.UrlRouterSpec exposing (tests)

import Css.Helpers exposing (identifierToString)
import Expect exposing (equal)
import Helpers exposing (fixtures, initialContext, signedInContext, someUser, successSignIn, successSignInWithoutProfile, toLocation)
import Layout.Styles exposing (Classes(OpenMenuButton, SignOutButton))
import Login.Ports exposing (signOut)
import Login.Styles
import Model as Root exposing (Model, Msg(..))
import Profile.Model exposing (Msg(..))
import Rides.Styles
import Test exposing (..)
import Testable.Html.Selectors exposing (..)
import Testable.Html.Types exposing (Selector)
import Testable.TestContext exposing (..)
import UrlRouter.Model exposing (Msg(UrlChange))
import UrlRouter.Routes exposing (Page(..), toPath)


tests : Test
tests =
    describe "UrlRouter"
        [ describe "initial routing"
            [ test "renders rides page if app starts on login page but user is already logged in" <|
                signedInContext LoginPage
                    >> expectToBeOnRidesPage
            , test "renders login page if app starts on rides page but user is not logged in" <|
                initialContext Nothing Nothing RidesPage
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
                >> successSignIn
                >> update (MsgForUrlRouter <| UrlChange (toLocation RidesPage))
                >> expectToBeOnRidesPage
        , test "redirects user to rides page if it is already logged in and goes to login page or home page" <|
            loginContext
                >> successSignIn
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
        , test "redirect to profile page if user does not have a profile yet" <|
            loginContext
                >> successSignInWithoutProfile
                >> Expect.all
                    [ update (MsgForUrlRouter <| UrlChange (toLocation LoginPage)) >> expectToBeOnProfilePage
                    , update (MsgForUrlRouter <| UrlChange (toLocation RidesPage)) >> expectToBeOnProfilePage
                    ]
        , test "do not redirect to profile page after creating on" <|
            loginContext
                >> successSignInWithoutProfile
                >> update (MsgForProfile <| ProfileResponse ( Nothing, Just fixtures.profile ))
                >> update (MsgForUrlRouter <| UrlChange (toLocation RidesPage))
                >> expectToBeOnRidesPage
        ]


loginContext : a -> TestContext Root.Msg Root.Model
loginContext =
    initialContext Nothing Nothing LoginPage


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
        >> successSignIn
        >> update (MsgForUrlRouter <| UrlChange (toLocation RidesPage))
        >> find [ layoutClass OpenMenuButton ]
        >> trigger "click" "{}"
        >> find [ layoutClass SignOutButton ]
        >> trigger "click" "{}"


expectToBeOnLoginPage : TestContext msg model -> Expect.Expectation
expectToBeOnLoginPage =
    Expect.all
        [ find [ layoutClass Layout.Styles.Page ]
            >> assertNodeCount (Expect.equal 0)
        , find [ loginClass Login.Styles.Page ]
            >> assertPresent
        ]


expectToBeOnRidesPage : TestContext msg Model -> Expect.Expectation
expectToBeOnRidesPage =
    currentModel
        >> Result.map (\model -> model.urlRouter.page)
        >> Expect.equal (Ok RidesPage)


expectToBeOnProfilePage : TestContext msg Model -> Expect.Expectation
expectToBeOnProfilePage =
    currentModel
        >> Result.map (\model -> model.urlRouter.page)
        >> Expect.equal (Ok ProfilePage)
