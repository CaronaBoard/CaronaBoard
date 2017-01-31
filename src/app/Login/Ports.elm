port module Login.Ports exposing (subscriptions, checkRegistration, signIn)

import Login.Model exposing (User)
import Login.Msg exposing (Msg(..))


subscriptions : Sub Msg
subscriptions =
    Sub.batch
        [ checkRegistrationResponse CheckRegistrationResponse
        , signInResponse SignInResponse
        ]



-- checkRegistration


port checkRegistration : String -> Cmd msg


port checkRegistrationResponse : (Bool -> msg) -> Sub msg



-- signIn


port signIn : { email : String, password : String } -> Cmd msg


type alias Error =
    String


port signInResponse : (( Maybe Error, Maybe User ) -> msg) -> Sub msg
