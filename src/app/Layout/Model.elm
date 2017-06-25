module Layout.Model exposing (Model, init)


type alias Model =
    { dropdownOpen : Bool
    }


init : Model
init =
    { dropdownOpen = False
    }
