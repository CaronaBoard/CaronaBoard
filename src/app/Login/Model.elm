module Login.Model exposing (Model, Msg(..), Step(..), User, isSignedIn, signedInUser, step)

import Common.Response exposing (Response(..))
import Profile.Model exposing (Profile)


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


type Step
    = EmailStep
    | NotRegisteredStep
    | PasswordStep


type Msg
    = UpdateEmail String
    | UpdatePassword String
    | Submit
    | CheckRegistrationResponse (Response Bool)
    | SignInResponse (Response { user : User, profile : Maybe Profile })
    | SignOut
    | SignOutResponse (Response Bool)
    | PasswordReset
    | PasswordResetResponse (Response Bool)
    | SignUpResponse (Response Bool)


type alias Error =
    String


step : Model -> Step
step model =
    case model.registered of
        Success True ->
            PasswordStep

        Success False ->
            NotRegisteredStep

        _ ->
            EmailStep


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
