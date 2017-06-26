module Helpers exposing (..)

import Expect
import Login.Model exposing (User)
import Model
import Msg
import Navigation exposing (Location)
import Rides.Model exposing (Contact, Ride, init)
import Testable.TestContext exposing (TestContext, startForTest)
import Update
import UrlRouter.Routes exposing (Page(..), toPath)
import View


initialContext : Maybe User -> Page -> a -> TestContext Msg.Msg Model.Model
initialContext currentUser page _ =
    startForTest
        { init = Model.init { currentUser = currentUser } (toLocation page)
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
    Just { id = "foo-bar-bar", name = "Baz" }


fixtures : { rides : List Ride, ride : Ride, user : User }
fixtures =
    { rides =
        [ { id = "ride-1", name = "foo", origin = "lorem", destination = "ipsum", days = "sit", hours = "amet", contact = { kind = "Whatsapp", value = "+5551" } }
        , { id = "ride-2", name = "bar", origin = "lorem", destination = "ipsum", days = "sit", hours = "amet", contact = { kind = "Whatsapp", value = "wpp-for-ride-2" } }
        ]
    , ride =
        { id = "ride-1", name = "foo", origin = "bar", destination = "baz, near qux", days = "Mon to Fri", hours = "18:30", contact = { kind = "Whatsapp", value = "+5551" } }
    , user =
        { id = "foo-bar-baz", name = "Baz" }
    }
