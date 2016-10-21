module Routesbox.FeedbackBox exposing (feedbackBox)

import Html exposing (Html, div, text, h3, a)
import Html.Attributes exposing (id, class, href, target)


feedbackBox : Html a
feedbackBox =
    div [ id "feedback" ]
        [ h3 []
            [ text "Nos ajude a melhorar!"
            ]
        , a [ class "cadastro", href "http://goo.gl/forms/GYVDfZuhWg", target "_blank" ]
            [ text "Deixe aqui sua opinião/sugestão"
            ]
        ]
