module Common.Link exposing (..)

import Html exposing (Attribute, Html, a)
import Html.Events exposing (onClick)
import Html.Styled
import Html.Styled.Events
import Model as RootMsg exposing (Msg(..))
import UrlRouter.Model exposing (Msg(Go))
import UrlRouter.Routes exposing (Page, toPath)


linkTo : Page -> List (Attribute RootMsg.Msg) -> List (Html RootMsg.Msg) -> Html RootMsg.Msg
linkTo page attributes =
    a
        ([ onClick (MsgForUrlRouter <| Go page)
         ]
            ++ attributes
        )


styledLinkTo : Page -> List (Html.Styled.Attribute RootMsg.Msg) -> List (Html.Styled.Html RootMsg.Msg) -> Html.Styled.Html RootMsg.Msg
styledLinkTo page attributes =
    Html.Styled.a
        ([ Html.Styled.Events.onClick (MsgForUrlRouter <| Go page)
         ]
            ++ attributes
        )
