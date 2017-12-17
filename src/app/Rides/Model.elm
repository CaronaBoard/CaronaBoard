module Rides.Model exposing (Collection, Model, Msg(..), NewRide, validation)

import Common.Response exposing (Response)
import Form exposing (Form)
import Form.Validate as Validate exposing (..)
import Profile.Model exposing (Profile)


type alias Collection =
    { list : Response (List Model)
    , new :
        { fields : Form () NewRide
        , response : Response Bool
        }
    }


type alias Model =
    { id : String
    , groupId : GroupId
    , userId : String
    , origin : String
    , destination : String
    , days : String
    , hours : String
    , profile : Profile
    }


type alias NewRide =
    { groupId : String
    , origin : String
    , destination : String
    , days : String
    , hours : String
    }


type Msg
    = UpdateRides (Response (List Model))
    | FormMsg GroupId Form.Msg
    | CreateRideResponse (Response Bool)


type alias GroupId =
    String


validation : String -> Validation () NewRide
validation groupId =
    Validate.succeed NewRide
        |> Validate.andMap (succeed groupId)
        |> Validate.andMap (field "origin" string)
        |> Validate.andMap (field "destination" string)
        |> Validate.andMap (field "days" string)
        |> Validate.andMap (field "hours" string)
