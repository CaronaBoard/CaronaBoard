module Model exposing (Model, Flags, init)

import UrlRouter.Model as UrlRouter
import Login.Model as Login
import Rides.Model as Rides
import Testable.Cmd
import Navigation exposing (Location)
import UrlRouter.Update as UrlRouterUpdate
import UrlRouter.Msg exposing (Msg(UrlChange))
import Msg exposing (Msg(MsgForUrlRouter))


type alias Model =
    { urlRouter : UrlRouter.Model
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
            { urlRouter = UrlRouter.init location
            , login = Login.init currentUser
            , rides = Rides.init
            }

        initialRouteChange =
            Testable.Cmd.map MsgForUrlRouter <| Tuple.second <| UrlRouterUpdate.update (MsgForUrlRouter <| UrlChange location) initialModel.urlRouter initialModel.login
    in
        ( initialModel
        , initialRouteChange
        )
