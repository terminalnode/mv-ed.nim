import os

## Get the name of the editor based on environmental variables.
## Order of priority is: VISUAL, EDITOR
## If none of these are defined, `none(string)` is returned
proc getEditor*(): string =
  return if existsEnv "VISUAL":
    getEnv "VISUAL"
  elif existsEnv "EDITOR":
    getEnv "EDITOR"
  else:
    stderr.writeLine("No editor defined")
    quit(1)