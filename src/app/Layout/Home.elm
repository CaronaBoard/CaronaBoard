module Layout.Home exposing (view)

import Testable.Html exposing (Html, div)
import Testable.Html.Attributes exposing (id, class)
import Model exposing (Model, Rider)
import Msg exposing (Msg(..))
import Layout.Header exposing (header)
import Instructions.Instructions exposing (instructions)
import Rides.RoutesList exposing (routesList)
import Login.View.Login exposing (login)
import Login.Model exposing (loggedInUser)


view : Model -> Html Msg
view model =
    div [ id "app" ]
        [ loginOrHomeScreen model ]


loginOrHomeScreen : Model -> Html Msg
loginOrHomeScreen model =
    case loggedInUser model.login of
        Just user ->
            div [ id "app-main" ]
                [ header
                , instructions
                , routesList model
                ]

        Nothing ->
            div [ id "app-login" ]
                [ div [ class "row" ]
                    [ Testable.Html.map MsgForLogin <| login model.login ]
                ]
