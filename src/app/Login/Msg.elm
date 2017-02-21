module Login.Msg exposing (Msg(..))

import Login.Model exposing (Model, Step(..), User, step)


type Msg
    = UpdateEmail String
    | UpdatePassword String
    | Submit
    | CheckRegistrationResponse Bool
    | SignInResponse ( Maybe Error, Maybe User )
    | SignOut
    | SignOutResponse
    | PasswordReset
    | PasswordResetResponse (Maybe Error)


type alias Error =
    String
