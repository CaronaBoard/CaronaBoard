module Update exposing (Msg(..), update)

import Model exposing (Model, Rider)
import Login.Update as Login


type Msg
    = UpdateRiders (List Rider)
    | UpdateLogin Login.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( modelUpdate msg model, cmdUpdate msg model )


modelUpdate : Msg -> Model -> Model
modelUpdate msg model =
    case msg of
        UpdateRiders riders ->
            { model | riders = riders }

        UpdateLogin loginMsg ->
            { model | login = Login.update loginMsg model.login }


cmdUpdate : Msg -> Model -> Cmd Msg
cmdUpdate msg model =
    case msg of
        UpdateRiders riders ->
            Cmd.none

        UpdateLogin loginMsg ->
            Cmd.map UpdateLogin <| Login.cmdUpdate loginMsg model.login
