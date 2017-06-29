port module Profile.Ports exposing (saveProfile, subscriptions)

import Common.Response exposing (FirebaseResponse, firebaseMap)
import Profile.Model exposing (Profile)
import Profile.Model exposing (Msg(..))


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ profileResponse ProfileResponse
        ]


port saveProfile : Profile -> Cmd msg


port profileResponse : (FirebaseResponse Profile -> msg) -> Sub msg
