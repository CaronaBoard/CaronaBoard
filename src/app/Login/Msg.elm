module Login.Msg exposing (Msg(..))

import Common.Response exposing (FirebaseResponse)
import Login.Model exposing (Model, Step(..), User, step)
import Profile.Model exposing (Profile)


type Msg
    = UpdateEmail String
    | UpdatePassword String
    | Submit
    | CheckRegistrationResponse Bool
    | SignInResponse (FirebaseResponse { user : User, profile : Maybe Profile })
    | SignOut
    | SignOutResponse
    | PasswordReset
    | PasswordResetResponse (Maybe Error)
    | SignUpResponse (FirebaseResponse Bool)


type alias Error =
    String
