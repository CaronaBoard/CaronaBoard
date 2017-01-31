module Login.Model exposing (Model, model, Step(..))


type alias Model =
    { email : String
    , step : Step
    }


type Step
    = EmailStep
    | PasswordStep


model : Model
model =
    { email = "", step = EmailStep }
