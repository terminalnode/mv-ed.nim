import std/algorithm
import std/os
import std/osproc
import std/strutils
import std/strformat
import std/sequtils
import std/tables

import mved/editorutils
import mved/strutils
import mved/tmpfile
  
when isMainModule:
  let
    (editor, editorVar) = getEditorOrDie()
    paths = commandLineParams()
      .mapIt(absolutePath(it))
      .sorted
      .deduplicate
    tempFile = getTempFile()
  echo fmt"Using editor: '{editor}' (from ${editorVar})"

  var
    pathMap = initTable[string, string](paths.len)
    tempFileContents = """
      # All the files to rename have received an index,
      # this index is what links the new path to the old
      # path so mv-ed knows which file to move where.
      #
      # To ignore a file, simply remove the line or comment
      # it out. Lines starting with # and lines consisting
      # of only whitespace will be ignored.
    """.unindent

  let padding = (paths.len + 1).intToStr.len
  var prevParent: string 

  for idx, value in paths.pairs:
    let parent = parentDir(value)
    if (prevParent != parent):
      prevParent = parent
      tempFileContents &&= ("\n# Directory: " & parent)

    let key = (idx+1).intToStr.align(padding, '0')
    pathMap[key] = value
    tempFileContents &&= fmt"{key} {value}"

  writeFileOrDie(tempFile, tempFileContents)
  echo fmt"Running '{editor} {tempFile}'"
  let exitCode = execCmd(fmt"{editor} {tempFile}")
  if exitCode != 0:
    echo fmt"Editor returned non-zero exit code ({exitCode}), aborting."
    quit(exitCode)

  # TODO split the lines into identifiers and paths
  # The output below is a list of identifiers and paths
  # together as one string
  let editedFile = readLinesOrDie(tempFile)
  echo "edited file:"
  for line in editedFile:
    echo line
  echo "---"
