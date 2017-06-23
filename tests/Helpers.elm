module Helpers exposing (..)

import Expect
import Login.Model exposing (User)
import Model
import Msg
import Navigation exposing (Location)
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


someUser : Maybe User
someUser =
    Just { id = "foo-bar-bar", name = "Baz" }
