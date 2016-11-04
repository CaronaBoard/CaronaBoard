port module Main exposing (..)

import Html exposing (Html, div, text, h3, a)
import Html.App as App
import Html.Attributes exposing (id, class, href, target)
import Header exposing (header)
import Instructions.Instructions exposing (instructions)
import RoutesBox.RoutesBox exposing (routesBox)


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = \msg model -> ( update msg model, Cmd.none )
        , subscriptions = subscriptions
        }


type alias Model =
    { riders : List Rider }


init : ( Model, Cmd Msg )
init =
    ( { riders = [] }, Cmd.none )


view : Model -> Html Msg
view model =
    div [ id "app-main" ]
        [ header
        , instructions
        , routesBox
        ]


type Msg
    = UpdateRiders (List Rider)


subscriptions : Model -> Sub Msg
subscriptions model =
    riders UpdateRiders


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateRiders riders ->
            { riders = riders }


type alias Rider =
    { id : String, name : String }


port riders : (List Rider -> msg) -> Sub msg
