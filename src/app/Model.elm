module Model exposing (Model, Flags, init)

import Router.Model as Router
import Login.Model as Login
import Rides.Model as Rides
import Testable.Cmd
import Navigation exposing (Location)
import Router.Update as RouterUpdate
import Router.Msg exposing (Msg(UrlChange))
import Msg exposing (Msg(MsgForRouter))


type alias Model =
    { router : Router.Model
    , login : Login.Model
    , rides : Rides.Model
    }


type alias Flags =
    { currentUser : Maybe Login.User
    }


init : Flags -> Location -> ( Model, Testable.Cmd.Cmd Msg.Msg )
init { currentUser } location =
    let
        initialModel =
            { router = Router.init location
            , login = Login.init currentUser
            , rides = Rides.init
            }
    in
        ( initialModel
        , Testable.Cmd.map MsgForRouter <| RouterUpdate.cmdUpdate (UrlChange location) initialModel.router initialModel.login
        )
