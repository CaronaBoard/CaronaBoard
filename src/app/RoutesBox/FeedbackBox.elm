module RoutesBox.FeedbackBox exposing (feedbackBox)

import Html exposing (Html, div, text, h3, a)
import Html.Attributes exposing (id, class, href, target, rel)


feedbackBox : Html a
feedbackBox =
    div [ id "feedback" ]
        [ h3 []
            [ text "Nos ajude a melhorar!"
            ]
        , a [ class "cadastro", href "http://goo.gl/forms/GYVDfZuhWg", rel "noopener", target "_blank" ]
            [ text "Deixe aqui sua opinião/sugestão"
            ]
        ]
