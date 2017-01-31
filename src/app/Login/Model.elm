module Login.Model exposing (Model, model, Response(..), LoggedIn(..), Step(..), User, step)


type alias Model =
    { email : String
    , password : String
    , registered : Response Bool
    , loggedIn : Response LoggedIn
    }


type alias User =
    { id : String, name : String }


type Step
    = EmailStep
    | PasswordStep


type Response a
    = Empty
    | Loading
    | Success a
    | Error String


type LoggedIn
    = LoggedIn User
    | LoggedOut


step : Model -> Step
step model =
    case model.registered of
        Success _ ->
            PasswordStep

        _ ->
            EmailStep


model : Model
model =
    { email = ""
    , password = ""
    , registered = Empty
    , loggedIn = Empty
    }
