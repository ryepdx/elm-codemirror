module Main exposing (..)

import Html exposing (..)
import CodeMirror exposing (..)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)


type alias Model =
  { code : String
  , lineNumbers : Bool
  , lineWrapping : Bool
  , theme : String
  , mode : String
  }


type Action
  = CodeChange String
  | ChangeLineNumbers Bool
  | ChangeLineWrapping Bool
  | ChangeTheme String
  | ChangeMode String


init : Model
init =
  { code = "main = \"Hello World\""
  , lineNumbers = True
  , lineWrapping = True
  , theme = "monokai"
  , mode = "elm"
  }


cmConfig : Model -> CmConfig
cmConfig model =
  { theme = model.theme
  , mode = model.mode
  , height = "auto"
  , lineNumbers = model.lineNumbers
  , lineWrapping = model.lineWrapping
  }



-- cmInstance : String -> String -> Html Cmd
-- cmInstance add code =
--   codeMirror CodeChange code


containerStyle =
  style [ ( "flex", "33% 0 0" ),("max-width", "33%"), ( "margin", "10px" ) ]


inputStyle =
  style [ ( "width", "100%" ), ( "margin-bottom", "10px" ) ]


container children =
  div [ containerStyle ] children



-- lazy way to test to see if it handles re-rendering well


codeMirrorView : Model -> Html Action
codeMirrorView model =
  if (model.theme == "hide") then
    div [] [ text "hidden" ]
  else
    codeMirror (cmConfig model) CodeChange model.code


header : Html Action
header =
  div
    []
    [ h2 [] [ text "elm-codemirror example" ]
    , p [] [ text "The 2 instances and the text area are bound to the same model. You can control theme and mode (only javascript and elm are loaded), and edit the code from a regular textarea too" ]
    ]


checkbox : Bool -> (Bool -> Action) -> String -> Html Action
checkbox isChecked tag name =
  div
    []
    [ input
        [ type_ "checkbox"
        , checked isChecked
        , onCheck tag
        ]
        []
    , text name
    , br [] []
    ]


view : Model -> Html Action
view model =
  div
    []
    [ header
    , div
        [ style [ ( "display", "flex" ) ] ]
        [ container
            [ h2 [] [ text "Instance 1" ], codeMirrorView model ]
        , container [ h2 [] [ text "Instance 2" ]
        , codeMirror (cmConfig model) CodeChange model.code ]
        , container
            [ h2
                []
                [ text "Controls" ]
            , div
                []
                [ text "Theme:"
                , input
                    [ placeholder "Theme"
                    , inputStyle
                    , value model.theme
                    , onInput ChangeTheme
                    ]
                    []
                ]
            , div
                []
                [ text "Mode (elm or javascript are loaded)"
                , input
                    [ placeholder "Mode"
                    , value model.mode
                    , inputStyle
                    , onInput ChangeMode
                    ]
                    []
                ]
            , div
                []
                [ text "Line numbers"
                , checkbox model.lineNumbers ChangeLineNumbers "Line numbers"
                ]
            , div
                []
                [ text "Line wrapping"
                , checkbox model.lineWrapping ChangeLineWrapping "Line wrapping"
                ]
            , div
                []
                [ text "\"raw\" code"
                , textarea
                    [ placeholder "Code"
                    , value model.code
                    , inputStyle
                    , onInput CodeChange
                    ]
                    []
                ]
            ]
        ]
    ]


update : Action -> Model -> Model
update acc model =
  case acc of
    CodeChange code ->
      { model | code = code }

    ChangeLineNumbers val ->
      { model | lineNumbers = val }

    ChangeLineWrapping val ->
      { model | lineWrapping = val }

    ChangeTheme theme ->
      { model | theme = theme }

    ChangeMode mode ->
      { model | mode = mode }


main =
  Html.beginnerProgram
    { model = init
    , update = update
    , view = view
    }
