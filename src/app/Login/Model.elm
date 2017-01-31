module Login.Model exposing (Model, model, Step(..), User(..))


type alias Model =
    { email : String
    , password : String
    , step : Step
    , user : User
    }


type Step
    = EmailStep
    | PasswordStep


type User
    = LoggedOut
    | LoggedIn String
    | Unregistered
    | Loading
    | Error String


model : Model
model =
    { email = ""
    , password = ""
    , step = EmailStep
    , user = LoggedOut
    }
