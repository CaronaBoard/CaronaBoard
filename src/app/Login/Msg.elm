module Login.Msg exposing (Msg(..))

import Common.Response exposing (FirebaseResponse)
import Login.Model exposing (Model, Step(..), User, step)


type Msg
    = UpdateEmail String
    | UpdatePassword String
    | Submit
    | CheckRegistrationResponse Bool
    | SignInResponse (FirebaseResponse User)
    | SignOut
    | SignOutResponse
    | PasswordReset
    | PasswordResetResponse (Maybe Error)
    | SignUpResponse (FirebaseResponse User)


type alias Error =
    String
