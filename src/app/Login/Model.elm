module Login.Model exposing (Model, Msg(..), User, isSignedIn, signedInUser)

import Common.Response exposing (..)
import Profile.Model exposing (Profile)
import RemoteData exposing (..)


type alias Model =
    { email : String
    , password : String
    , registered : Response Bool
    , signedIn : Response User
    , passwordReset : Response Bool
    , signUp : Response Bool
    }


type alias User =
    { id : String }


type Msg
    = UpdateEmail String
    | SubmitEmail
    | CheckRegistrationResponse (Response Bool)
    | UpdatePassword String
    | SubmitPassword
    | SignInResponse (Response { user : User, profile : Maybe Profile })
    | SubmitRegistration
    | SignUpResponse (Response Bool)
    | PasswordReset
    | PasswordResetResponse (Response Bool)
    | SignOut
    | SignOutResponse (Response Bool)


signedInUser : Model -> Maybe User
signedInUser model =
    case model.signedIn of
        Success user ->
            Just user

        _ ->
            Nothing


isSignedIn : Model -> Bool
isSignedIn model =
    case signedInUser model of
        Just _ ->
            True

        Nothing ->
            False
