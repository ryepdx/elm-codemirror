module CodeMirror exposing (CmConfig, codeMirror)

{-| This library fills a bunch of important niches in Elm. A `Maybe` can help
you with optional arguments, error handling, and records with optional fields.

# Definition
@docs Maybe

# Common Helpers
@docs map, withDefault, oneOf

# Chaining Maybes
@docs andThen

-}

import Html exposing (Html)
import Native.CodeMirror


type alias Config =
  { value : String
  , cmConfig : CmConfig
  }


type alias CmConfig =
  { theme : String
  , mode : String
  , height : String
  , lineNumbers : Bool
  , lineWrapping : Bool
  }


codeMirror_ : Config -> (String -> msg) -> Html a
codeMirror_ =
  Native.CodeMirror.codeMirror


codeMirror : CmConfig -> (String -> msg) -> String -> Html a
codeMirror config msgCreator code =
  codeMirror_ { cmConfig = config, value = code } msgCreator
