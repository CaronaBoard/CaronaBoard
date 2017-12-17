port module Stylesheets exposing (..)

import DEPRECATED.Css.File exposing (CssCompilerProgram, CssFileStructure)
import Groups.Styles
import Layout.Styles
import Login.Styles
import Notifications.Styles
import Profile.Styles
import Rides.Styles


port files : CssFileStructure -> Cmd msg


fileStructure : CssFileStructure
fileStructure =
    DEPRECATED.Css.File.toFileStructure
        [ ( "main.css"
          , DEPRECATED.Css.File.compile
                [ Layout.Styles.styles
                , Login.Styles.styles
                , Rides.Styles.styles
                , Notifications.Styles.styles
                , Profile.Styles.styles
                , Groups.Styles.styles
                ]
          )
        ]


main : CssCompilerProgram
main =
    DEPRECATED.Css.File.compiler files fileStructure
