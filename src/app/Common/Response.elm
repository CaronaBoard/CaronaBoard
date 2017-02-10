module Common.Response exposing (Response(..))


type Response a
    = Empty
    | Loading
    | Success a
    | Error String
