port module Stylesheets exposing (..)

import DEPRECATED.Css.File exposing (CssCompilerProgram, CssFileStructure)
import Layout.Styles


port files : CssFileStructure -> Cmd msg


fileStructure : CssFileStructure
fileStructure =
    DEPRECATED.Css.File.toFileStructure
        [ ( "main.css"
          , DEPRECATED.Css.File.compile
                [ Layout.Styles.styles
                ]
          )
        ]


main : CssCompilerProgram
main =
    DEPRECATED.Css.File.compiler files fileStructure
