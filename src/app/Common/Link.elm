module Common.Link exposing (..)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Events exposing (..)
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


styledLinkTo : Page -> List Style -> List (Attribute RootMsg.Msg) -> List (Html RootMsg.Msg) -> Html RootMsg.Msg
styledLinkTo page style attributes =
    styled a
        style
        ([ onClick (MsgForUrlRouter <| Go page)
         ]
            ++ attributes
        )
