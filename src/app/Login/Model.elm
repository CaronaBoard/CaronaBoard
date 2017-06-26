module Login.Model exposing (Model, Step(..), User, init, isLoggedIn, loggedInUser, step)

import Common.Response exposing (Response(..))


type alias Model =
    { email : String
    , password : String
    , registered : Response Bool
    , loggedIn : Response User
    , passwordReset : Response ()
    , signUp : Response Bool
    }


type alias User =
    { id : String, name : String }


type Step
    = EmailStep
    | NotRegisteredStep
    | PasswordStep


step : Model -> Step
step model =
    case model.registered of
        Success True ->
            PasswordStep

        Success False ->
            NotRegisteredStep

        _ ->
            EmailStep


loggedInUser : Model -> Maybe User
loggedInUser model =
    case model.loggedIn of
        Success user ->
            Just user

        _ ->
            Nothing


isLoggedIn : Model -> Bool
isLoggedIn model =
    case loggedInUser model of
        Just _ ->
            True

        Nothing ->
            False


init : Maybe User -> Model
init user =
    { email = ""
    , password = ""
    , registered = Empty
    , loggedIn =
        user
            |> Maybe.map Success
            |> Maybe.withDefault Empty
    , passwordReset = Empty
    , signUp = Empty
    }
