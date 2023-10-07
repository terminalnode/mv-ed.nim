import os, strutils, strformat, sequtils, sugar
import ./editor_utils

when isMainModule:
  let paths = commandLineParams()
    .map((x) => absolutePath(x))
  let editor = getEditor()
    
  echo fmt"args: {paths}"
  echo fmt"Editor: {editor}"
