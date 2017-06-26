module Profile.Msg exposing (Msg(..))

import Common.Response exposing (FirebaseResponse)
import Profile.Model exposing (Profile)


type Msg
    = UpdateName String
    | UpdateContactType String
    | UpdateContactValue String
    | Submit
    | ProfileResponse (FirebaseResponse Profile)
