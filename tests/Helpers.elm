module Helpers exposing (..)

import Common.Response exposing (Response(..))
import Expect
import GiveRide.Model exposing (NewRide)
import Login.Model exposing (Msg(..), User)
import Model
import Navigation exposing (Location)
import Profile.Model exposing (Profile)
import Rides.Model as Rides
import Rides.Ride.Model as Ride
import String.Extra
import Testable.TestContext exposing (..)
import Update
import UrlRouter.Routes exposing (Page(..), toPath)
import View


initialContext : Maybe User -> Maybe Profile -> Page -> a -> TestContext Model.Msg Model.Model
initialContext currentUser profile page _ =
    startForTest
        { init = Update.init { currentUser = currentUser, profile = profile } (toLocation page)
        , update = Update.update
        , view = View.view
        }


signedInContext : Page -> a -> TestContext Model.Msg Model.Model
signedInContext =
    initialContext someUser (Just fixtures.profile)


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


successSignIn : TestContext Model.Msg model -> TestContext Model.Msg model
successSignIn =
    update (Model.MsgForLogin <| SignInResponse (Success { user = fixtures.user, profile = Just fixtures.profile }))


successSignInWithoutProfile : TestContext Model.Msg model -> TestContext Model.Msg model
successSignInWithoutProfile =
    update (Model.MsgForLogin <| SignInResponse (Success { user = fixtures.user, profile = Nothing }))


jsonQuotes : String -> String
jsonQuotes =
    String.Extra.replace "'" "\""


fixtures : { rides : Rides.Model, ride : Ride.Model, user : User, profile : Profile, newRide : NewRide }
fixtures =
    let
        user =
            { id = "foo-bar-bar" }

        profile =
            { name = "foo", contact = { kind = "Whatsapp", value = "passenger-wpp" } }

        ride1 =
            { id = "ride-1", userId = "user-1", origin = "bar", destination = "baz, near qux", days = "Mon to Fri", hours = "18:30", profile = { name = "foo", contact = { kind = "Whatsapp", value = "+5551" } }, rideRequest = Empty }

        ride2 =
            { id = "ride-2", userId = "user-2", origin = "lorem", destination = "ipsum", days = "sit", hours = "amet", profile = { name = "bar", contact = { kind = "Whatsapp", value = "wpp-for-ride-2" } }, rideRequest = Empty }

        newRide =
            { origin = "bar", destination = "baz, near qux", days = "Mon to Fri", hours = "18:30" }
    in
    { rides = [ ride1, ride2 ]
    , ride = ride1
    , user = user
    , profile = profile
    , newRide = newRide
    }
