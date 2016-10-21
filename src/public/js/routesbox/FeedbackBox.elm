module FeedbackBox exposing (..)

import Html exposing (Html, div, text, h3, a)
import Html.App as App
import Html.Attributes exposing (id, class, href, target)


main : Program Never
main =
    App.beginnerProgram { model = Nothing, view = view, update = \_ _ -> Nothing }


view : a -> Html a
view model =
    div [ id "feedback" ]
        [ h3 []
            [ text "Nos ajude a melhorar!"
            ]
        , a [ class "cadastro", href "http://goo.gl/forms/GYVDfZuhWg", target "_blank" ]
            [ text "Deixe aqui sua opinião/sugestão"
            ]
        ]
