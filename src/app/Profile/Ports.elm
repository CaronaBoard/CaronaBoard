port module Profile.Ports exposing (saveProfile, subscriptions)

import Common.Response exposing (FirebaseResponse, fromFirebase)
import Profile.Model exposing (Msg(..), Profile)


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ profileResponse (fromFirebase >> ProfileResponse)
        ]


port saveProfile : Profile -> Cmd msg


port profileResponse : (FirebaseResponse Profile -> msg) -> Sub msg
