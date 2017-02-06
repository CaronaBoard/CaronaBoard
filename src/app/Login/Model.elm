module Login.Model exposing (Model, init, Response(..), Step(..), User, step, loggedInUser)


type alias Model =
    { email : String
    , password : String
    , registered : Response Bool
    , loggedIn : Response User
    }


type alias User =
    { id : String, name : String }


type Step
    = EmailStep
    | NotRegisteredStep
    | PasswordStep


type Response a
    = Empty
    | Loading
    | Success a
    | Error String


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


init : Maybe User -> Model
init user =
    { email = ""
    , password = ""
    , registered = Empty
    , loggedIn =
        user
            |> Maybe.map Success
            |> Maybe.withDefault Empty
    }
