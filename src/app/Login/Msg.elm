module Login.Msg exposing (Msg(..))

import Login.Model exposing (Model, Response(..), Step(..), User, step)


type Msg
    = UpdateEmail String
    | UpdatePassword String
    | Submit
    | CheckRegistrationResponse Bool
    | SignInResponse ( Maybe Error, Maybe User )
    | SignOut
    | SignOutResponse


type alias Error =
    String
