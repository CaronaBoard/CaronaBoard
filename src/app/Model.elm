module Model exposing (Model, Flags, init)

import UrlRouter.Model as UrlRouter
import Login.Model as Login
import Rides.Model as Rides
import Layout.Model as Layout
import Testable.Cmd
import Navigation exposing (Location)
import UrlRouter.Update as UrlRouterUpdate
import UrlRouter.Msg exposing (Msg(UrlChange))
import Msg exposing (Msg(MsgForUrlRouter))


type alias Model =
    { urlRouter : UrlRouter.Model
    , login : Login.Model
    , rides : Rides.Model
    , layout : Layout.Model
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
            , layout = Layout.init
            }
    in
        updateUrlRouter location initialModel


updateUrlRouter : Location -> Model -> ( Model, Testable.Cmd.Cmd Msg.Msg )
updateUrlRouter location model =
    let
        updatedUrlRouter =
            UrlRouterUpdate.update (MsgForUrlRouter <| UrlChange location) model.urlRouter model.login
    in
        ( { model | urlRouter = Tuple.first updatedUrlRouter }
        , Testable.Cmd.map MsgForUrlRouter <| Tuple.second updatedUrlRouter
        )
