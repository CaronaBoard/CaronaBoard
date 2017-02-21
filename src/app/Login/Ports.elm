port module Login.Ports exposing (subscriptions, checkRegistration, signIn, signOut, passwordReset, passwordResetResponse)

import Login.Model exposing (User)
import Login.Msg exposing (Msg(CheckRegistrationResponse, SignInResponse, SignOutResponse, PasswordResetResponse))


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ checkRegistrationResponse CheckRegistrationResponse
        , signInResponse SignInResponse
        , signOutResponse (always SignOutResponse)
        , passwordResetResponse PasswordResetResponse
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



-- passwordReset


port passwordReset : String -> Cmd msg


port passwordResetResponse : (Maybe Error -> msg) -> Sub msg
