import std/os

type EditorInfo =
  tuple[editor: string, envVar: string]

## Get the name of the editor based on environmental variables.
## Order of priority is: VISUAL, EDITOR
## If none of these are defined, `none(string)` is returned
proc getEditorOrDie*(): EditorInfo =
  return if existsEnv "VISUAL":
    (getEnv "VISUAL", "VISUAL")
  elif existsEnv "EDITOR":
    (getEnv "EDITOR", "EDITOR")
  else:
    stderr.writeLine("No editor defined")
    quit(1)
