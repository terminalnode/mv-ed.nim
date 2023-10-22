import std/os
import std/strutils
import std/sequtils

## Alias for `writeFile` that will print an error message
## and exit if it fails to write the file.
proc writeFileOrDie*(
  filename: string,
  content: string
) =
  try:
    writeFile(filename, content)
  except IOError:
    echo "Failed to write to file: " & filename
    quit(1)
    
## Alias for `readLines` that will print an error message
## and exit if it fails to read the file.
proc readLinesOrDie*(
  filename: string
): seq[string] =
  return try:
    readFile(filename)
      .split("\n")
      .filter(proc(it: string): bool =
        let commented = it.startsWith("#")
        let empty = it.isEmptyOrWhitespace
        return not commented and not empty
      )
  except IOError:
    echo "Failed to read file: " & filename
    quit(1)

## Create a file in the temp directory called 'mv-ed'.
proc getTempFile*(): string =
  let tempDir = getTempDir()
  let path = tempDir / "mv-ed"
  
  if fileExists path:
    removeFile path

  return path
