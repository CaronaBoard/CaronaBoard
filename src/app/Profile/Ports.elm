port module Profile.Ports exposing (decodeProfile, saveProfile, subscriptions)

import Common.Response exposing (FirebaseResponse, decodeFromFirebase)
import Json.Decode as Json exposing (..)
import Json.Decode.Pipeline exposing (..)
import Profile.Model exposing (Contact, Msg(..), Profile)


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ profileResponse (decodeFromFirebase decodeProfile >> ProfileResponse)
        ]


decodeProfile : Decoder Profile
decodeProfile =
    decode Profile
        |> required "name" string
        |> required "contact"
            (decode Contact
                |> required "kind" string
                |> required "value" string
            )


port saveProfile : Profile -> Cmd msg


port profileResponse : (FirebaseResponse Json.Value -> msg) -> Sub msg
