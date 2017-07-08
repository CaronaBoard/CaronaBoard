module Integration.UrlRouterSpec exposing (tests)

import Common.Response exposing (Response(..))
import Css.Helpers exposing (identifierToString)
import Expect exposing (equal)
import Helpers exposing (fixtures, initialContext, signedInContext, someUser, successSignIn, successSignInWithoutProfile, toLocation)
import Layout.Styles exposing (Classes(SignOutButton))
import Login.Ports exposing (signOut)
import Login.Styles
import Model as Root exposing (Model, Msg(..))
import Profile.Model exposing (Msg(..))
import Test exposing (..)
import Test.Html.Event exposing (click)
import Test.Html.Query exposing (..)
import Test.Html.Selector exposing (..)
import TestContext exposing (..)
import UrlRouter.Model exposing (Msg(UrlChange))
import UrlRouter.Routes exposing (Page(..), toPath)


tests : Test
tests =
    describe "UrlRouter"
        [ describe "initial routing"
            [ test "renders rides page if app starts on login page but user is already signed in" <|
                signedInContext LoginPage
                    >> expectToBeOnGroupsPage
            , test "renders login page if app starts on rides page but user is not signed in" <|
                initialContext Nothing Nothing GroupsPage
                    >> expectToBeOnLoginPage
            ]
        , test "renders login and hides rides when user is not signed in and is on login route" <|
            loginContext
                >> expectToBeOnLoginPage
        , test "redirects user to login page if it is not signed in and goes to home or page" <|
            loginContext
                >> Expect.all
                    [ update (MsgForUrlRouter <| UrlChange (toLocation GroupsPage)) >> expectToBeOnLoginPage
                    , update (MsgForUrlRouter <| UrlChange (toLocation SplashScreenPage)) >> expectToBeOnLoginPage
                    ]
        , test "renders groups and hides login when user is signed in and on groups route" <|
            loginContext
                >> successSignIn
                >> update (MsgForUrlRouter <| UrlChange (toLocation GroupsPage))
                >> expectToBeOnGroupsPage
        , test "redirects user to groups page if it is already signed in and goes to login page or home page" <|
            loginContext
                >> successSignIn
                >> Expect.all
                    [ update (MsgForUrlRouter <| UrlChange (toLocation LoginPage)) >> expectToBeOnGroupsPage
                    , update (MsgForUrlRouter <| UrlChange (toLocation SplashScreenPage)) >> expectToBeOnGroupsPage
                    ]
        , describe "logout"
            [ test "trigger port on sign out button click" <|
                loginThenLogout
                    >> expectCmd (Cmd.map MsgForLogin <| signOut ())
            , test "does not log user out until the response from firebase" <|
                loginThenLogout
                    >> expectToBeOnGroupsPage
            ]
        , test "redirect to profile page if user does not have a profile yet" <|
            loginContext
                >> successSignInWithoutProfile
                >> Expect.all
                    [ update (MsgForUrlRouter <| UrlChange (toLocation LoginPage)) >> expectToBeOnProfilePage
                    , update (MsgForUrlRouter <| UrlChange (toLocation GroupsPage)) >> expectToBeOnProfilePage
                    ]
        , test "do not redirect to profile page after creating on" <|
            loginContext
                >> successSignInWithoutProfile
                >> update (MsgForProfile <| ProfileResponse (Success fixtures.profile))
                >> update (MsgForUrlRouter <| UrlChange (toLocation GroupsPage))
                >> expectToBeOnGroupsPage
        ]


loginContext : a -> TestContext Root.Model Root.Msg
loginContext =
    initialContext Nothing Nothing LoginPage


layoutClass : Layout.Styles.Classes -> Selector
layoutClass =
    Test.Html.Selector.class << identifierToString Layout.Styles.namespace


loginClass : Login.Styles.Classes -> Selector
loginClass =
    Test.Html.Selector.class << identifierToString Login.Styles.namespace


loginThenLogout : a -> TestContext Model Root.Msg
loginThenLogout =
    loginContext
        >> successSignIn
        >> update (MsgForUrlRouter <| UrlChange (toLocation GroupsPage))
        >> simulate (find [ id "openMenu" ]) click
        >> simulate (find [ layoutClass SignOutButton ]) click


expectToBeOnLoginPage : TestContext model msg -> Expect.Expectation
expectToBeOnLoginPage =
    expectView
        >> Expect.all
            [ has [ loginClass Login.Styles.Page ]
            , hasNot [ layoutClass Layout.Styles.Page ]
            ]


expectToBeOnGroupsPage : TestContext Model msg -> Expect.Expectation
expectToBeOnGroupsPage =
    expectModel
        (\model ->
            Expect.equal GroupsPage model.urlRouter.page
        )


expectToBeOnProfilePage : TestContext Model msg -> Expect.Expectation
expectToBeOnProfilePage =
    expectModel
        (\model ->
            Expect.equal ProfilePage model.urlRouter.page
        )
