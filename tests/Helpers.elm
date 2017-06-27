module Helpers exposing (..)

import Expect
import GiveRide.Model exposing (NewRide)
import Login.Model exposing (User)
import Login.Msg exposing (Msg(..))
import Model
import Msg
import Navigation exposing (Location)
import Profile.Model exposing (Profile)
import Rides.Model exposing (Ride, init)
import Testable.TestContext exposing (..)
import Update
import UrlRouter.Routes exposing (Page(..), toPath)
import View


initialContext : Maybe User -> Page -> a -> TestContext Msg.Msg Model.Model
initialContext currentUser page _ =
    startForTest
        { init = Model.init { currentUser = currentUser, profile = Just fixtures.profile } (toLocation page)
        , update = Update.update
        , view = View.view
        }


toLocation : Page -> Location
toLocation page =
    { href = "", host = "", hostname = "", protocol = "", origin = "", port_ = "", pathname = "", search = "", hash = toPath page, username = "", password = "" }


expectToContainText : String -> String -> Expect.Expectation
expectToContainText expected actual =
    Expect.true ("Expected\n\t" ++ actual ++ "\nto contain\n\t" ++ expected)
        (String.contains expected actual)


expectToNotContainText : String -> String -> Expect.Expectation
expectToNotContainText expected actual =
    Expect.false ("Expected\n\t" ++ actual ++ "\nto NOT contain\n\t" ++ expected)
        (String.contains expected actual)


someUser : Maybe User
someUser =
    Just fixtures.user


successSignIn : TestContext Msg.Msg model -> TestContext Msg.Msg model
successSignIn =
    update (Msg.MsgForLogin <| SignInResponse ( Nothing, Maybe.map (\user -> { user = user, profile = Just fixtures.profile }) someUser ))


successSignInWithoutProfile : TestContext Msg.Msg model -> TestContext Msg.Msg model
successSignInWithoutProfile =
    update (Msg.MsgForLogin <| SignInResponse ( Nothing, Maybe.map (\user -> { user = user, profile = Nothing }) someUser ))


fixtures : { rides : List Ride, ride : Ride, user : User, profile : Profile, newRide : NewRide }
fixtures =
    let
        user =
            { id = "foo-bar-bar" }

        profile =
            { name = "foo", contact = { kind = "Whatsapp", value = "passenger-wpp" } }

        ride1 =
            { id = "ride-1", origin = "bar", destination = "baz, near qux", days = "Mon to Fri", hours = "18:30", profile = { name = "foo", contact = { kind = "Whatsapp", value = "+5551" } } }

        ride2 =
            { id = "ride-2", origin = "lorem", destination = "ipsum", days = "sit", hours = "amet", profile = { name = "bar", contact = { kind = "Whatsapp", value = "wpp-for-ride-2" } } }

        newRide =
            { origin = "bar", destination = "baz, near qux", days = "Mon to Fri", hours = "18:30" }
    in
    { rides = [ ride1, ride2 ]
    , ride = ride1
    , user = user
    , profile = profile
    , newRide = newRide
    }
