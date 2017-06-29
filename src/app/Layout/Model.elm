module Layout.Model exposing (Model, Msg(..))


type alias Model =
    { dropdownOpen : Bool
    }


type Msg
    = OpenDropdown
    | CloseDropdown
