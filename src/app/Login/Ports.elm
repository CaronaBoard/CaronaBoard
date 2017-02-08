port module Login.Ports exposing (subscriptions, checkRegistration, signIn, signOut)

import Login.Model exposing (User)
import Login.Msg exposing (Msg(..))


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ checkRegistrationResponse CheckRegistrationResponse
        , signInResponse SignInResponse
        , signOutResponse (always SignOutResponse)
        ]



-- checkRegistration


port checkRegistration : String -> Cmd msg


port checkRegistrationResponse : (Bool -> msg) -> Sub msg



-- signIn


port signIn : { email : String, password : String } -> Cmd msg


type alias Error =
    String


port signInResponse : (( Maybe Error, Maybe User ) -> msg) -> Sub msg



-- signOut


port signOut : () -> Cmd msg


port signOutResponse : (() -> msg) -> Sub msg
