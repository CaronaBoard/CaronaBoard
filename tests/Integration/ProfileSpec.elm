module Integration.ProfileSpec exposing (tests)

import Common.Response exposing (Response(..))
import Expect exposing (equal)
import Helpers exposing (expectToContainText, fixtures, initialContext, someUser, successSignIn, toLocation)
import Model as Root exposing (Model, Msg(..))
import Navigation
import Profile.Model exposing (Msg(..))
import Profile.Ports
import Rides.Model exposing (Msg(..))
import Test exposing (..)
import Test.Html.Events as Events exposing (Event(..))
import Test.Html.Query exposing (..)
import Test.Html.Selector exposing (..)
import TestContext exposing (..)
import UrlRouter.Routes exposing (Page(..), toPath)


tests : Test
tests =
    describe "Profile" <|
        [ test "fill the fields correctly" <|
            fillProfile
                >> expectView
                >> find [ id "name" ]
                >> has [ attribute "value" "foo" ]
        , test "shows loading on submit" <|
            submitProfile
                >> expectView
                >> find [ id "submitProfile" ]
                >> has [ text "Carregando..." ]
        , test "sends request via saveProfile port" <|
            submitProfile
                >> expectCmd (Cmd.map MsgForProfile <| Profile.Ports.saveProfile fixtures.profile)
        , test "shows error when profile port returns an error" <|
            submitProfile
                >> update (MsgForProfile <| ProfileResponse (Error "undefined is not a function"))
                >> expectView
                >> has [ text "not a function" ]

        -- , test "shows notification on success" <|
        --     submitProfile
        --         >> successResponse
        --         >> expectView
        --         >> has [ text "Perfil atualizado com sucesso" ]
        -- , test "goes to the rides page on success" <|
        --     submitProfile
        --         >> successResponse
        --         >> assertCalled (Cmd.map MsgForUrlRouter <| Navigation.newUrl <| toPath RidesPage)
        -- , test "set profile on login response" <|
        --     profileContext
        --         >> successSignIn
        --         >> expectView
        --         >> Expect.all
        --             [ find [ id "name" ]
        --                 >> has [ attribute "value" fixtures.profile.name ]
        --             , find [ id "contactValue" ]
        --                 >> has [ attribute "value" fixtures.profile.contact.value ]
        --             ]
        ]


profileContext : a -> TestContext Model Root.Msg
profileContext =
    initialContext someUser Nothing ProfilePage
        >> update (MsgForRides <| UpdateRides fixtures.rides)


fillProfile : a -> TestContext Model Root.Msg
fillProfile =
    profileContext
        >> simulate (find [ id "name" ]) (Events.Input fixtures.profile.name)
        >> simulate (find [ id "contactKind" ]) (Events.Input fixtures.profile.contact.kind)
        >> simulate (find [ id "contactValue" ]) (Events.Input fixtures.profile.contact.value)


submitProfile : a -> TestContext Model Root.Msg
submitProfile =
    fillProfile
        >> simulate (find [ tag "form" ]) Events.Submit


successResponse : TestContext Model Root.Msg -> TestContext Model Root.Msg
successResponse =
    update (MsgForProfile <| ProfileResponse (Success fixtures.profile))
