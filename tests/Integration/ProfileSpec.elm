module Integration.ProfileSpec exposing (tests)

import Expect exposing (equal)
import Helpers exposing (expectToContainText, fixtures, initialContext, someUser, successSignIn, toLocation)
import Model exposing (Model)
import Msg as Root exposing (Msg(..))
import Navigation
import Profile.Model exposing (Msg(..))
import Profile.Ports
import Rides.Msg exposing (Msg(..))
import Test exposing (..)
import Testable.Html.Selectors exposing (..)
import Testable.TestContext exposing (..)
import UrlRouter.Routes exposing (Page(..), toPath)


tests : Test
tests =
    describe "requests a ride" <|
        [ test "fill the fields correctly" <|
            fillProfile
                >> find [ id "name" ]
                >> assertAttribute "value" (Expect.equal "foo")
        , test "shows loading on submit" <|
            submitProfile
                >> find [ id "submitProfile" ]
                >> assertText (Expect.equal "Carregando...")
        , test "sends request via saveProfile port" <|
            submitProfile
                >> assertCalled (Cmd.map MsgForProfile <| Profile.Ports.saveProfile fixtures.profile)
        , test "shows error when profile port returns an error" <|
            submitProfile
                >> update (MsgForProfile <| ProfileResponse ( Just "undefined is not a function", Nothing ))
                >> find []
                >> assertText (expectToContainText "not a function")
        , test "shows notification on success" <|
            submitProfile
                >> successResponse
                >> find []
                >> assertText (expectToContainText "Perfil atualizado com sucesso")
        , test "goes to the rides page on success" <|
            submitProfile
                >> successResponse
                >> assertCalled (Cmd.map MsgForUrlRouter <| Navigation.newUrl <| toPath RidesPage)
        , test "set profile on login response" <|
            profileContext
                >> successSignIn
                >> Expect.all
                    [ find [ id "name" ]
                        >> assertAttribute "value" (Expect.equal fixtures.profile.name)
                    , find [ id "contactValue" ]
                        >> assertAttribute "value" (Expect.equal fixtures.profile.contact.value)
                    ]
        ]


profileContext : a -> TestContext Root.Msg Model
profileContext =
    initialContext someUser Nothing ProfilePage
        >> update (MsgForRides <| UpdateRides fixtures.rides)


fillProfile : a -> TestContext Root.Msg Model
fillProfile =
    profileContext
        >> find [ id "name" ]
        >> trigger "input" ("{\"target\": {\"value\": \"" ++ fixtures.profile.name ++ "\"}}")
        >> find [ id "contactKind" ]
        >> trigger "input" ("{\"target\": {\"value\": \"" ++ fixtures.profile.contact.kind ++ "\"}}")
        >> find [ id "contactValue" ]
        >> trigger "input" ("{\"target\": {\"value\": \"" ++ fixtures.profile.contact.value ++ "\"}}")


submitProfile : a -> TestContext Root.Msg Model
submitProfile =
    fillProfile
        >> find [ tag "form" ]
        >> trigger "submit" "{}"


successResponse : TestContext Root.Msg Model -> TestContext Root.Msg Model
successResponse =
    update (MsgForProfile <| ProfileResponse ( Nothing, Just fixtures.profile ))
