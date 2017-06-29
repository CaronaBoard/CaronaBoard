port module Login.Ports exposing (checkRegistration, passwordReset, passwordResetResponse, signIn, signOut, signUp, subscriptions)

import Common.Response exposing (FirebaseResponse)
import Login.Model exposing (User)
import Login.Model exposing (Msg(..))
import Profile.Model exposing (Profile)


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ checkRegistrationResponse CheckRegistrationResponse
        , signInResponse SignInResponse
        , signOutResponse (always SignOutResponse)
        , passwordResetResponse PasswordResetResponse
        , signUpResponse SignUpResponse
        ]



-- checkRegistration


port checkRegistration : String -> Cmd msg


port checkRegistrationResponse : (Bool -> msg) -> Sub msg



-- signIn


port signIn : { email : String, password : String } -> Cmd msg


port signInResponse : (FirebaseResponse { user : User, profile : Maybe Profile } -> msg) -> Sub msg



-- signOut


port signOut : () -> Cmd msg


port signOutResponse : (() -> msg) -> Sub msg



-- passwordReset


port passwordReset : String -> Cmd msg


type alias Error =
    String


port passwordResetResponse : (Maybe Error -> msg) -> Sub msg



-- signUp


port signUp : { email : String, password : String } -> Cmd msg


port signUpResponse : (FirebaseResponse Bool -> msg) -> Sub msg
