module Layout.Model exposing (Model, Msg(..), init)


type alias Model =
    { dropdownOpen : Bool
    }


type Msg
    = OpenDropdown
    | CloseDropdown


init : Model
init =
    { dropdownOpen = False
    }
