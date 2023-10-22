import std/os
import std/strutils

type EditorInfo =
  tuple[editor: string, envVar: string]

proc editorInfoFromEnv(
  key: string,
): EditorInfo = (
  editor: getEnv(key),
  envVar: key,
)

## Get the name of the editor based on environmental variables.
## Order of priority is: VISUAL, EDITOR
## If none of these are defined, `none(string)` is returned
proc getEditorOrDie*(): EditorInfo =
  return if existsEnv "VISUAL":
    editorInfoFromEnv("VISUAL")
  elif existsEnv "EDITOR":
    editorInfoFromEnv("EDITOR")
  else:
    stderr.writeLine(
      """
        No editor defined, you need to set your editor in the environment.
        Do this by setting either $VISUAL (preferred) or $EDITOR.
        Aborting...
      """.unindent
    )
    quit(1)
