module Integration.ProfileSpec exposing (tests)

import Expect exposing (equal)
import Helpers exposing (expectToContainText, fixtures, initialContext, someUser, successSignIn, toLocation)
import Json.Encode as Encode exposing (Value)
import Model as Root exposing (Model, Msg(..))
import Profile.Model exposing (Msg(..))
import Profile.Ports
import RemoteData exposing (RemoteData(..))
import Rides.Model exposing (Msg(..))
import Test exposing (..)
import Test.Html.Event exposing (custom, input, submit)
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
                >> has [ attribute "defaultValue" fixtures.profile.name ]
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
                >> update (MsgForProfile <| ProfileResponse (Failure "undefined is not a function"))
                >> expectView
                >> has [ text "not a function" ]
        , test "shows notification on success" <|
            submitProfile
                >> successResponse
                >> expectView
                >> has [ text "Perfil atualizado com sucesso" ]
        , test "goes to the groups page on success" <|
            submitProfile
                >> successResponse
                >> expectModel
                    (\model ->
                        Expect.equal GroupsListPage model.urlRouter.page
                    )
        , test "leave profile fields filled after returning to profile page" <|
            profileContext
                >> successSignIn
                >> navigate (toPath ProfilePage)
                >> expectView
                >> Expect.all
                    [ find [ id "name" ]
                        >> has [ attribute "defaultValue" fixtures.profile.name ]
                    , find [ id "contactValue" ]
                        >> has [ attribute "defaultValue" fixtures.profile.contact.value ]
                    ]
        ]


profileContext : a -> TestContext Model Root.Msg
profileContext =
    initialContext someUser Nothing ProfilePage
        >> update (MsgForRides <| UpdateRides <| Success fixtures.rides)


fillProfile : a -> TestContext Model Root.Msg
fillProfile =
    let
        changeEvent : Value
        changeEvent =
            Encode.object
                [ ( "target"
                  , Encode.object [ ( "value", Encode.string fixtures.profile.contact.kind ) ]
                  )
                ]
    in
    profileContext
        >> simulate (find [ id "name" ]) (input fixtures.profile.name)
        >> simulate (find [ id "contactKind" ]) (custom "change" changeEvent)
        >> simulate (find [ id "contactValue" ]) (input fixtures.profile.contact.value)


submitProfile : a -> TestContext Model Root.Msg
submitProfile =
    fillProfile
        >> simulate (find [ tag "form" ]) submit


successResponse : TestContext Model Root.Msg -> TestContext Model Root.Msg
successResponse =
    update (MsgForProfile <| ProfileResponse (Success fixtures.profile))
