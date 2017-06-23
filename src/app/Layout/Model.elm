module Layout.Model exposing (Model, init)


type alias Model =
    { dropdownOpen : Bool
    , notification : Maybe String
    }


init : Model
init =
    { dropdownOpen = False
    , notification = Nothing
    }
